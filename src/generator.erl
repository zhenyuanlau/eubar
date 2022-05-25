-module(generator).
-export([start/0, loop/1, emit/1]).

-spec start() -> {ok,pid()}.
start() ->
  Pid = spawn_link(?MODULE, loop, [5000]),
  register(generator, Pid),
  {ok, Pid}.

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
