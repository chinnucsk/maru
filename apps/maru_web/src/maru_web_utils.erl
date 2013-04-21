%%%-------------------------------------------------------------------
%%% @author Tristan Sloughter <>
%%% @copyright (C) 2011, Tristan Sloughter
%%% @doc
%%%
%%% @end
%%% Created : 10 Jul 2011 by Tristan Sloughter <>
%%%-------------------------------------------------------------------
-module(maru_web_utils).

-include_lib("maru_web/include/maru_web.hrl").
-include_lib("kernel/include/file.hrl").

%% API
-export([checkbox_value_to_bool/1]).

%%%===================================================================
%%% API
%%%===================================================================

checkbox_value_to_bool(undefined) ->
    false;
checkbox_value_to_bool("on") ->
    true;
checkbox_value_to_bool("off") ->
    false.

%%%===================================================================
%%% Internal functions
%%%===================================================================
