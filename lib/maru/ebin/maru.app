%% -*- erlang -*-
%% This is the application resource file (.app file) for the maru,
%% application.
{application, maru,
  [{description, "Maru Erlang web application framework scripts"},
   {vsn, "0.1.0"},
   {modules, [maru]},
   {registered,[]},
   {applications, [kernel, stdlib, sgte]},
   {start_phases, []}]}.
