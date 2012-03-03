%%%-------------------------------------------------------------------
%%% @author Tristan Sloughter <>
%%% @copyright (C) 2012, Tristan Sloughter
%%% @doc
%%%
%%% @end
%%% Created : 29 Feb 2012 by Tristan Sloughter <>
%%%-------------------------------------------------------------------
-module(maru).

%% API
-export([main/1]).

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------
main(_Args) ->
    create_project("test_project", "tp"),
    create_model("tp", "newmodel"),
    ok.

create_model(AppPrefix, ModelName) ->
    maru_create_model:create(AppPrefix, ModelName).

%%%===================================================================
%%% Internal functions
%%%===================================================================

create_project(ProjectName, AppPrefix) ->
    create_dirs(project, ProjectName, AppPrefix),
    create_config(ProjectName, AppPrefix),
    create_app_files(ProjectName, AppPrefix),
    create_source_files(ProjectName, AppPrefix),
    create_start_script(ProjectName, AppPrefix).

create_config(ProjectName, AppPrefix) ->
    maru_utils:write_template(build_config, [{project_name, ProjectName},
                                             {project_prefix, AppPrefix},
                                             {project_version, "0.0.1"}],
                              filename:join(ProjectName, "sinan.config")).

create_app_files(ProjectName, AppPrefix) ->
    [create_app_file(Type, ProjectName, AppPrefix) ||
        Type <- [core, db, models, web]]. %%ops, functional_test]].

create_app_file(core, ProjectName, AppPrefix) ->
    Deps = [list_to_atom(AppPrefix++"_models"), list_to_atom(AppPrefix++"_ops")],
    create_app_file("core", ProjectName, AppPrefix, Deps);
create_app_file(db, ProjectName, AppPrefix) ->
    Deps = [maru_idioms, maru_db],
    create_app_file("db", ProjectName, AppPrefix, Deps);
create_app_file(models, ProjectName, AppPrefix) ->
    Deps = [sasl, maru_models],
    create_app_file("models", ProjectName, AppPrefix, Deps);
create_app_file(web, ProjectName, AppPrefix) ->
    Deps = [ssl, maru_web, maru_mail, list_to_atom(AppPrefix++"_models")],
    create_app_file("web", ProjectName, AppPrefix, Deps).

create_app_file(Type, ProjectName, AppPrefix, Deps) ->
    FileName = filename:join([ProjectName, "lib",                              
                              [AppPrefix, "_", Type], "src", [AppPrefix, "_", Type, ".app.src"]]),
    maru_utils:write_template(app, [{project_name, ProjectName},
                                {modules, "[]"},
                                {registered, ProjectName++"_sup"},
                                {deps, string:join([atom_to_list(D) || D <- Deps], ", ")},
                                {app_prefix, AppPrefix}], FileName).

create_source_files(_ProjectName, _AppPrefix) ->
    ok.

create_start_script(_ProjectName, _AppPrefix) ->
    ok.

create_dirs(project, ProjectName, AppPrefix) ->
    create_dir(["./", ProjectName]),
    lists:foreach(fun(DirName) ->
                          create_dir(["./", ProjectName, DirName])
                  end, ["bin", "config" | lib_dirs(AppPrefix)]).   

create_dir(Path) ->
    DirPath = filename:join(Path),
    filelib:ensure_dir(DirPath),
    file:make_dir(DirPath).

lib_dirs(AppPrefix) ->
    [filename:join(["lib", [AppPrefix, "_", X], Y])  || X <- ["core", "db", "models", "ops", "web", "functional_test"], Y <- ["ebin/", "include/", "priv/", "src/"]].
    
