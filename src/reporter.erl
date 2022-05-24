-module(reporter).
-include("include/data.hrl").
-export([start/0, init/0, loop/0]).
-export([call/1, reply/2, stop/0]).

start() ->
  Pid = spawn(?MODULE, init, []),
  register(reporter, Pid),
  {ok, Pid}.

init() ->
  loop().

loop() ->
  receive
    {request, Pid, query} ->
      {ok, Reply} = file:read_file(?REPORT_FILE),
      reply(Pid, Reply),
      loop();
    {request, Pid, stop} ->
      reply(Pid, ok)
  end.


stop() -> call(stop).

call(Message) ->
  reporter ! {request, self(), Message},
  receive
    {reply, Reply} ->
      Reply
  end.

reply(Pid, Reply) ->
  Pid ! {reply, Reply}.
