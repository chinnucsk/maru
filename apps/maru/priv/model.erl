%%%-------------------------------------------------------------------
%%% @author $author$ <>
%%% @copyright (C) $year$, $author$
%%% @doc
%%%
%%% @end
%%% Created :  $date# by $author$ <>
%%%-------------------------------------------------------------------
-module($name$).
-extends(maru_model_base).

-include_lib("maru_models/include/maru_model.hrl").
-include_lib("maru_models/include/jsonerl.hrl").

-include_lib("eunit/include/eunit.hrl").

%% API
-export([all/0,
         all_keys/0,
         find/1,
         to_json/1,
         to_record/1]).

-record(?MODULE, {$fields$}).

%%%===================================================================
%%% API
%%%===================================================================

all_keys() ->
    maru_db:all_keys(?MODULE).

all() ->
    maru_db:all(?MODULE).

find(Criteria) when is_list(Criteria) ->
    maru_db:find(?MODULE, Criteria);
find(Criteria) when is_tuple(Criteria)->
    maru_db:find(?MODULE, [Criteria]).

to_json(Record) ->
    ?record_to_json(?MODULE, Record).

to_record(JSON) ->
    ?json_to_record(?MODULE, JSON).


%%%===================================================================
%%% Internal functions
%%%===================================================================

%%%===================================================================
%%% Test functions
%%%===================================================================
p
