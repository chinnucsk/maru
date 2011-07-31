%%%-------------------------------------------------------------------
%%% @author Tristan Sloughter <>
%%% @copyright (C) 2011, Tristan Sloughter
%%% @doc
%%%
%%% @end
%%% Created :  5 Jul 2011 by Tristan Sloughter <>
%%%-------------------------------------------------------------------
-module(maru_db).

-include_lib("idioms/include/idioms.hrl").

%% API
-export([create_table/2,
         store/1,
         find/2,
         match/2]).

%%%===================================================================
%%% API
%%%===================================================================

create_table(Name, Fields) ->
    mnesia:create_table(Name, [{attributes, Fields}]).

store(Record) when not(is_list(Record))->
    store([Record]);
store(Records) when is_list(Records)->
    case mnesia:transaction(?FUN(lists:foreach(?FUN1(mnesia:write(X)), Records))) of
        {atomic, ok} ->
            ok;
        _ ->
            error
    end.

-spec find(atom(), list(tuple())) -> record().
find(Tab, PropList) ->
    Obj = Tab:new(match_spec(Tab, PropList)),
    case mnesia:transaction(
           ?FUN(mnesia:match_object(Obj))) of
        {atomic, []} ->
            not_found;
        {atomic, [Result]} ->
            Result;
        _ ->
            error
    end.

-spec match(atom(), list(tuple())) -> record().
match(Tab, PropList) ->
    Obj = Tab:new(match_spec(Tab, PropList)),
    case mnesia:transaction(
           ?FUN(mnesia:match_object(Obj))) of
        {atomic, []} ->
            not_found;
        {atomic, Result} ->
            Result;
        _ ->
            error
    end.

%%%===================================================================
%%% Internal functions
%%%===================================================================

match_spec(Tab, PropList) ->
    lists:ukeymerge(1, lists:keysort(1, PropList), lists:keysort(1, wildcard_match_spec(Tab))).

wildcard_match_spec(Tab) ->
    lists:map(?FUN1({X, '_'}), Tab:fields()).