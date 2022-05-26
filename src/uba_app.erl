-module(uba_app).
-export([start/2, stop/1]).

start(_Type, _Args) ->
    ChildSpecList = [
      {generator, start, []},
      {collector, start, []},
      {processor, start, []},
      {reporter, start, []},
      {dashboard, start, []}
    ],
    uba_sup:start(uba, ChildSpecList).

stop(_State) ->
  uba_sup:stop(uba).
