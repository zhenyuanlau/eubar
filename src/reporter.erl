-module(reporter).
-include("include/data.hrl").
-export([start/0, init/0, loop/0]).
-export([call/1, reply/2, stop/0]).

-spec start() -> {ok,pid()}.

start() ->
  Pid = spawn(?MODULE, init, []),
  register(reporter, Pid),
  {ok, Pid}.

init() ->
  loop().

loop() ->
  receive
    {request, Pid, query} ->
      handle_open(Pid, file:read_file(?REPORT_FILE)),
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

handle_open(Pid, {ok, Reply}) ->
  reply(Pid, Reply);
handle_open(Pid, {error, Reason}) ->
  reply(Pid, Reason).
