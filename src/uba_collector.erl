-module(uba_collector).

-behaviour(gen_event).

-export([start_link/0, init/1, handle_call/2, handle_event/2, terminate/2]).

start_link() ->
  {ok, Pid} = gen_event:start_link({local, ?MODULE}),
  gen_event:add_handler(?MODULE, ?MODULE, []),
  {ok, Pid}.

init(_Args) ->
  {ok, []}.

handle_event(Event, State) ->
  error_logger:info_msg("***Received Event*** ~p~n", [Event]),
  {ok, State}.

handle_call(_Request, _State) ->
  {ok, reply, []}.

terminate(_Args, _State) ->
  ok.
