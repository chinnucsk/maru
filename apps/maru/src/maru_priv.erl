%%%-------------------------------------------------------------------
%%% @author Tristan Sloughter <>
%%% @copyright (C) 2012, Tristan Sloughter
%%% @doc
%%%
%%% @end
%%% Created :  4 Mar 2012 by Tristan Sloughter <>
%%%-------------------------------------------------------------------
-module(maru_priv).

%% API
-export([install_priv/1]).

-define(TMP_DIR, "/tmp/maru_priv/").

%%%===================================================================
%%% API
%%%===================================================================

install_priv(ProjectName) ->
    file:make_dir(?TMP_DIR),
    TarGz = get_priv(),
    extract_priv(ProjectName, TarGz).

%%%===================================================================
%%% Internal functions
%%%===================================================================

get_priv() ->    
    {ok, {_SC, _Headers, Body}} = httpc:request("http://github.com/downloads/tsloughter/maru/maru_priv-0.0.1.tar.gz"),
    Body.

extract_priv(ProjectName, TarGz) ->
    ok = erl_tar:extract({binary, TarGz}, [compressed, {cwd, [filename:join("./", ProjectName)]}]).
    
    
