-module(processor).

-export([start/0]).

-spec start() -> {ok, pid()}.
start() ->
  Pid = spawn(fun() -> void end),
  {ok, Pid}.
