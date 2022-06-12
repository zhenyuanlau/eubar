-module(eubar_counter).

-behaviour(gen_event).

-export([init/1, handle_event/2, handle_call/2]).

init([]) ->
  TableId = ets:new(?MODULE, []),
  {ok, TableId}.

handle_event(Event, TableId) ->
  try ets:update_counter(TableId, Event, 1) of
    _ok ->
      {ok, TableId}
  catch
    error:_ ->
      ets:insert(TableId, {Event, 1}),
      {ok, TableId}
  end.

handle_call(Request, State) ->
  {ok, Request, State}.
