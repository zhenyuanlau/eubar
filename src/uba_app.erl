-module(uba_app).
-export([start/0, stop/0]).

start() ->
    ChildSpecList = [
      {generator, start, []},
      {collector, start, []},
      {processor, start, []},
      {reporter, start, []},
      {dashboard, start, []}
    ],
    uba_sup:start(uba, ChildSpecList).

stop() ->
  uba_sup:stop(uba).
