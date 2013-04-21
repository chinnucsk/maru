%%%-------------------------------------------------------------------
%%% @author Tristan Sloughter <>
%%% @copyright (C) 2012, Tristan Sloughter
%%% @doc
%%%
%%% @end
%%% Created :  1 Mar 2012 by Tristan Sloughter <>
%%%-------------------------------------------------------------------
-module(maru_utils).

%% API
-export([write_template/3]).

%%%===================================================================
%%% API
%%%===================================================================

write_template(TemplateName, Variables, FileName) ->
    Content = lists:flatten(maru_skel:TemplateName()),
    {ok, Template} = sgte:compile(Content),
    AppFile = sgte:render_bin(Template, Variables),
    file:write_file(FileName, AppFile).

%%%===================================================================
%%% Internal functions
%%%===================================================================
