-module(uba_processor).

-behaviour(gen_event).

-export([start_link/0, init/1, handle_call/2, handle_event/2]).

start_link() ->
  {ok, Pid} = gen_event:start_link({local, ?MODULE}),
  gen_event:add_handler(?MODULE, ?MODULE, []),
  {ok, Pid}.

init(_InitArgs) ->
  {ok, []}.

handle_event(_Event, _State) ->
  {ok, []}.

handle_call(_Request, _State) ->
  {ok, reply, []}.
