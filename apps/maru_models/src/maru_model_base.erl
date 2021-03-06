%%%-------------------------------------------------------------------
%%% @author Tristan Sloughter <>
%%% @copyright (C) 2011, Tristan Sloughter
%%% @doc
%%%
%%% @end
%%% Created :  5 Jul 2011 by Tristan Sloughter <>
%%%-------------------------------------------------------------------
-module(maru_model_base).

%% API
-export([save/1,
	 update/1]).

%%%===================================================================
%%% API
%%%===================================================================

save(Model) ->
    maru_db:store(Model).

update(Model) ->
    maru_db:update(Model).

%%%===================================================================
%%% Internal functions
%%%===================================================================
