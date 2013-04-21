%%%-------------------------------------------------------------------
%%% @author Tristan Sloughter <>
%%% @copyright (C) 2012, Tristan Sloughter
%%% @doc
%%%
%%% @end
%%% Created :  2 Mar 2012 by Tristan Sloughter <>
%%%-------------------------------------------------------------------
-module(maru_skel).

%% API
-export([app/0,
         model/0,
         run_script/0,
         edoc_overview/0,
         build_config/0,
         sysconfig/0,
         header/0]).

%%%===================================================================
%%% API
%%%===================================================================

app() ->
    ["%% -*- erlang -*-\n"
     "%% This is the application resource file (.app file) for the $project_name$,\n"
     "%% application.\n"
     "{application, maru,\n"
     "[{description, \"$project_name$\"},\n"
     " {vsn, \"0.1.0\"},\n"
     " {modules, $modules$},\n"
     " {registered,[$registered$]},\n"
     " {applications, [kernel, stdlib, $deps$]},\n"
     " {mod, {$app_prefix$_app,[]}},\n"
     " {start_phases, []}]}."].

model() ->
    [].

run_script() ->
    ["#!/bin/sh"
     "\n"
     "PROG=$$0"
     "PROG_DIR=$$(cd `dirname $$0`; pwd)"
     "test -h $$0 && PROG=$$(readlink $$0)"
     "export ROOTDIR=$$(dirname $$PROG_DIR)/_build"
     "\n"
     "#### Fill in values for these variables ####"
     "REL_NAME=$project_name$"
     "REL_VSN=$project_version$"
     "###########################################"
     "\n"
     "export BINDIR=$$ERTS_DIR/bin"
     "export EMU=beam"
     "export PROGNAME=erl"
     "export LD_LIBRARY_PATH=$$ERTS_DIR/lib"
     "\n"
     "export REL_DIR=$$ROOTDIR/$$REL_NAME/releases/$$REL_VSN"
     "MNESIA_DIR=$$HOME/mnesia_data"
     "\n"
     "$$BINDIR/erl -sname $project_prefix$ -config $$REL_DIR/sys.config -boot $$REL_DIR/$$REL_NAME -prefix $$ROOTDIR -mnesia dir `echo \'$$HOME/mnesia_data\'`"].


%% @doc Writes out a overview.edoc to the filename provided.
edoc_overview() ->
    ["@author $author$ <$email$>\n"
     "@copyright $Year$, $author$\n"
     "@version $vsn$\n"].

%% @doc Writes the build_config to the specified library with the specified
%% repo.
build_config() ->
    ["{project_name, $project_name$}.\n"
     "{project_prefix, $project_prefix$}.\n"
     "{project_vsn, \"$project_version$\"}.\n"
     "\n"
     "{build_dir,  \"_build\"}.\n"
     "\n"
     "{ignore_dirs, [\"_\", \".\"]}.\n"
     "\n"
     "{ignore_apps, []}.\n"].

%% @doc Writes the sys config out to the specifiecd place
sysconfig() ->
    ["%%% -*- mode:erlang -*-\n"
     "%%% Warning - this config file *must* end with <dot><whitespace>\n"
     "\n"
     "[ {$project_name$, []} ].\n"].    

header() ->
    ["%%%----------------------------------------------------------------\n"
     "%%% @author  $author$ <$email$>\n"
     "%%% @doc\n"
     "%%% @end\n"
     "%%% @copyright $year$, $author$\n"
     "%%%----------------------------------------------------------------\n"].

