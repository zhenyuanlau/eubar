-module(dashboard).

-export([start/0]).

-spec start() -> {ok, pid()}.
start() ->
  {ok, spawn(fun() -> void end)}.
