%%%----------------------------------------------------------------
%%% @author Tristan Sloughter <tristan.sloughter@gmail.com>
%%% @doc
%%%
%%% @end
%%% @copyright 2011 Tristan Sloughter
%%%----------------------------------------------------------------,
-module(maru_db_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%%===================================================================
%%% Application callbacks
%%%===================================================================

%% @private
-spec start(normal | {takeover, node()} | {failover, node()},
            any()) -> {ok, pid()} | {ok, pid(), State::any()} |
                      {error, Reason::any()}.
start(_StartType, _StartArgs) ->
    case maru_db_sup:start_link() of
        {ok, PID} ->
            {ok, PID};
        Error ->
            Error
    end.

%% @private
-spec stop(State::any()) -> ok.
stop(_State) ->
    ok.

%%%===================================================================
%%% Internal functions
%%%===================================================================


