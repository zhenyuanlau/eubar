%%%-------------------------------------------------------------------
%% @doc eubar public API
%% @end
%%%-------------------------------------------------------------------

-module(eubar_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    case eubar_sup:start_link() of
        {ok, Sup} ->
            {ok, Sup};
        {error, _Reason} = Error ->
            Error
    end.

stop(_State) ->
    ok.

%% internal functions
