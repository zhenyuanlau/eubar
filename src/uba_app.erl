-module(uba_app).
-export([start/0, stop/0]).

start() ->
    ChildSpecList = [
      {reporter, start, []}
    ],
    uba_sup:start(uba, ChildSpecList).

stop() ->
    ok.

