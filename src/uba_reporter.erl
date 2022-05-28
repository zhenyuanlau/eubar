-module(uba_reporter).

-export([call/1]).
-export([start/0, init/1, loop/0, reply/2, stop/0]).

-include("include/data.hrl").

-spec start() -> {ok, pid()}.
start() ->
  Pid = spawn(?MODULE, init, [[]]),
  register(reporter, Pid),
  {ok, Pid}.

init(_Args) ->
  loop().

loop() ->
  receive
    {request, Pid, query} ->
      handle_open(Pid, file:read_file(?REPORT_FILE)),
      loop();
    {request, Pid, stop} ->
      reply(Pid, ok)
  end.

stop() ->
  call(stop).

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
