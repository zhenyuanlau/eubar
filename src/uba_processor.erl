-module(uba_processor).

-behaviour(gen_event).

-export([start_link/0, init/1, handle_call/2, handle_event/2]).

start_link() ->
  case gen_event:start_link({local, ?MODULE}) of
    {ok, Pid} ->
      gen_event:add_sup_handler(?MODULE, uba_counter, []),
      gen_event:add_sup_handler(?MODULE, uba_sinker, []),
      {ok, Pid};
    Error ->
      Error
  end.

init(_InitArgs) ->
  {ok, []}.

handle_event(_Event, _State) ->
  {ok, []}.

handle_call(_Request, _State) ->
  {ok, reply, []}.
