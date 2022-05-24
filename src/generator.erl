-module(generator).
-export([start/0, loop/1, emit/1]).

start() ->
  spawn_link(?MODULE, loop, [5000]).

timer(Timeout, Fun) ->
  receive
    _ ->
      void
  after
    Timeout ->
      Fun()
  end.

emit(Event) ->
  collector:rpc({event, Event}).

loop(Interval) ->
  timer(Interval, fun () -> spawn(?MODULE, emit, ["click"]) end),
  loop(Interval).
