%% -*- erlang -*-
%% This is the application resource file (.app file) for the $project_name$,
%% application.
{application, maru,
  [{description, "$project_name$"},
   {vsn, "0.1.0"},
   {modules, $modules$},
   {registered,[$registered$]},
   {applications, [kernel, stdlib, $deps$]},
   {mod, {$app_prefix$_app,[]}},
   {start_phases, []}]}.
