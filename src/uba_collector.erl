-module(uba_collector).

-behaviour(gen_server).

-export([start_link/0, init/1, handle_call/3, handle_cast/2]).

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init(_Args) ->
  {ok, []}.

handle_call({event, Event}, _From, State) ->
  gen_event:notify(uba_processor, Event),
  {reply, ok, State}.

handle_cast(Request, _State) ->
  {noreply, gen_server:call(?MODULE, Request)}.
