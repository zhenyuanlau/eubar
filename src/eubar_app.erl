%%%-------------------------------------------------------------------
%% @doc eubar public API
%% @end
%%%-------------------------------------------------------------------

-module(eubar_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    eubar_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
