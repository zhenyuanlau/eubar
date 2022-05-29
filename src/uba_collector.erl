-module(uba_collector).

-behaviour(gen_event).

-include("include/records.hrl").

-export([start_link/0, init/1, handle_call/2, handle_event/2, terminate/2]).

start_link() ->
  {ok, Pid} = gen_event:start_link({local, ?MODULE}),
  gen_event:add_handler(?MODULE, ?MODULE, []),
  {ok, Pid}.

init(_Args) ->
  TableId = ets:new(event, [ordered_set, {keypos, #event.evt_id}, named_table]),
  {ok, TableId}.

handle_event(Event, TableId) ->
  ets:insert_new(TableId, Event),
  gen_event:notify(uba_processor, {TableId, Event}),
  {ok, TableId}.

handle_call(_Request, _State) ->
  {ok, reply, []}.

terminate(_Args, _State) ->
  ok.
