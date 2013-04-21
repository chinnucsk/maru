-compile({parse_transform, cut}).
-compile({parse_transform, do}).

-define(NOTIFY_AIRBRAKE(Type, Reason, Message),
        airbrake:notify(Type, Reason, Message, ?MODULE, ?LINE, erlang:get_stacktrace())).

%% Emacs-friendly error_logger messages.
%% These macros generate emacs-clickable lines of text.
-define(ILOG(Atoms, Message, Args),
        maru_idioms:Atoms(?MODULE, ?LINE, io:format(Message, Args))).
-define(INFO(Message, Args),
        ?ILOG(log_info, Message, Args)).
-define(WARN(Message, Args),
        ?ILOG(log_warn, Message, Args)).
-define(ERROR(Message, Args),
        ?ILOG(log_error, Message, Args)).

-define(INFO(Message), maru_idioms:log_info(?MODULE, ?LINE, Message)).
-define(WARN(Message), maru_idioms:log_warn(?MODULE, ?LINE, Message)).
-define(ERROR(Message), maru_idioms:log_error(?MODULE, ?LINE, Message)).

-define(FUN(Body), fun() ->
                           Body
                   end).

-define(FUN1(Body), fun(X) ->
                           Body
                    end).

-define(DEFAULT(X, Y), case X of
                           undefined ->
                               Y;
                           not_found ->
                               Y;
                           _ ->
                               X
                       end).
