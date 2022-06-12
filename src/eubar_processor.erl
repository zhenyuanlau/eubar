-module(eubar_processor).

-behaviour(gen_event).

-export([start_link/0, init/1, handle_call/2, handle_event/2]).

start_link() ->
  case gen_event:start_link({local, ?MODULE}) of
    {ok, Pid} ->
      add_event_handler(eubar_counter, []),
      add_event_handler(eubar_sinker, []),
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

%% private
add_event_handler(Handler, Args) ->
  gen_event:add_sup_handler(?MODULE, Handler, Args).
