%%
%% 支持 WebSocket
%%
-module(uba_dashboard).

-behaviour(gen_server).

-export([start_link/0, init/1, handle_cast/2, handle_call/3]).

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init(_Args) ->
  {ok, []}.

handle_call(_Request, _From, _State) ->
  {reply, reply, []}.

handle_cast(_Request, _State) ->
  {noreply, []}.
