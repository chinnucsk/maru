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
    ok.

%%%===================================================================
%%% Internal functions
%%%===================================================================

create_project(ProjectName, AppPrefix) ->
    create_dirs(project, ProjectName, AppPrefix),    
    create_app_files(ProjectName, AppPrefix),
    create_source_files(ProjectName, AppPrefix),
    create_start_script(ProjectName, AppPrefix).

create_app_files(ProjectName, AppPrefix) ->
    [create_app_file(Type, ProjectName, AppPrefix) ||
        Type <- [core, db, models, web]]. %%ops, functional_test]].

create_app_file(core, ProjectName, AppPrefix) ->
    Modules = [list_to_atom(AppPrefix++"_core_sup"),
               list_to_atom(AppPrefix++"_core_app"),
               list_to_atom(AppPrefix++"_core")],
    Deps = [list_to_atom(AppPrefix++"_models"), list_to_atom(AppPrefix++"_ops")],
    create_app_file("core", ProjectName, AppPrefix, Modules, Deps);
create_app_file(db, ProjectName, AppPrefix) ->
    Modules = [AppPrefix++"_db"],
    Deps = [maru_idioms, maru_db],
    create_app_file("db", ProjectName, AppPrefix, Modules, Deps);
create_app_file(models, ProjectName, AppPrefix) ->
    Modules = [list_to_atom(AppPrefix++"_models")],
    Deps = [sasl, maru_models],
    create_app_file("models", ProjectName, AppPrefix, Modules, Deps);
create_app_file(web, ProjectName, AppPrefix) ->
    Modules = [list_to_atom(AppPrefix++"_web")],
    Deps = [ssl, maru_web, maru_mail, AppPrefix++"_models"],
    create_app_file("web", ProjectName, AppPrefix, Modules, Deps).


create_app_file(Type, ProjectName, AppPrefix, Modules, Deps) ->
    FileName = filename:join([ProjectName, "lib",                              
                              [AppPrefix, "_", Type], "ebin", [AppPrefix, "_", Type, ".app"]]),
    write_template("base.app", [{project_name, ProjectName},
                                {modules, io_lib:format("~p", [Modules])},
                                {registered, ProjectName++"_sup"},
                                {deps, io_lib:format("~p", [Deps])},
                                {app_prefix, AppPrefix}], FileName).

create_source_files(_ProjectName, _AppPrefix) ->
    ok.

create_start_script(_ProjectName, _AppPrefix) ->
    ok.

write_template(TemplateFile, Variables, FileName) ->
    PrivDir = "/home/tristan/Devel/maru/lib/maru/priv", %code:priv_dir(?MODULE),
    {ok, Binary} = file:read_file(filename:join(PrivDir, TemplateFile)),
    {ok, Template} = sgte:compile(Binary),
    AppFile = sgte:render_bin(Template, Variables),
    file:write_file(FileName, AppFile).

create_dirs(project, ProjectName, AppPrefix) ->
    create_dir(["./", ProjectName]),
    lists:foreach(fun(DirName) ->
                          create_dir(["./", ProjectName, DirName])
                  end, ["bin", "config" | lib_dirs(AppPrefix)]).   

create_dir(Path) ->
    filelib:ensure_dir(filename:join(Path)).

lib_dirs(AppPrefix) ->
    [filename:join(["lib", [AppPrefix, "_", X], Y])  || X <- ["core", "db", "models", "ops", "web", "functional_test"], Y <- ["ebin", "include", "priv", "src"]].
    
