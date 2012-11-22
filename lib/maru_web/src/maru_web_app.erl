%%%----------------------------------------------------------------
%%% @author Tristan Sloughter <tristan.sloughter@gmail.com>
%%% @doc
%%%
%%% @end
%%% @copyright 2011 Tristan Sloughter
%%%----------------------------------------------------------------,
-module(maru_web_app).

-behaviour(application).

%% Application callbacks
-export([start/0, start/2, stop/1]).

%%%===================================================================
%%% Application callbacks
%%%===================================================================
start() ->
    start_deps(maru_web, permanent).

start_deps(App, Type) ->
    case application:start(App, Type) of
        ok ->
            ok;
        {error, {not_started, Dep}} ->
            start_deps(Dep, Type),
            start_deps(App, Type)
    end.

%% @private
-spec start(normal | {takeover, node()} | {failover, node()},
            any()) -> {ok, pid()} | {ok, pid(), State::any()} |
                      {error, Reason::any()}.
start(_StartType, _StartArgs) ->
    case maru_web_sup:start_link() of
        {ok, Pid} ->
            {ok, Pid};
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


