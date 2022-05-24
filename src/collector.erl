-module(collector).
-export([start/0, rpc/1, loop/1]).

start() ->
  P = spawn(?MODULE, loop, [[]]),
  register(collector, P).

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
    Any ->
      io:format("Recevied:~p~n", [Any]),
      loop(EventList)
  after
    30000 ->
      timeout
  end.

