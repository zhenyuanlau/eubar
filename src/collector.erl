-module(collector).
-export([start/0, rpc/1, loop/1]).

-spec start() -> {ok,pid()}.

start() ->
  Pid = spawn(?MODULE, loop, [[]]),
  register(collector, Pid),
  {ok, Pid}.

rpc(Request) ->
  collector ! {self(), Request},
  receive
    {Client, Response} ->
      Client ! Response
  end.

loop(EventList) ->
  receive
    {From, {event, Event}} ->
      From ! {self(), ok},
      loop([Event|EventList]);
    {From, {view}} ->
      From ! {self(), EventList},
      loop(EventList);
    _Any ->
      loop(EventList)
  after
    30000 ->
      timeout
  end.

