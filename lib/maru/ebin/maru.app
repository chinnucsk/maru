%% -*- erlang -*-
%% This is the application resource file (.app file) for the maru,
%% application.
{application, maru,
  [{description, "Maru Erlang web application framework scripts"},
   {vsn, "0.1.0"},
   {modules, [maru,
              maru_create_model,
              maru_utils,
              maru_priv,
              maru_deps,
              maru_skel]},
   {registered,[]},
   {applications, [kernel, stdlib, sgte, inets]},
   {start_phases, []}]}.
