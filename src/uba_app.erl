%%
%% 应用模块 <application-name>_app.erl
%% 负责启动 <根监督者>
%%
%% 在运行时, 应用就是一棵由监督者和工作者进程共同构成的进程树, 树根就是监督者.
%%
%% -behaviour(application).
%%
-module(uba_app).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
  ChildSpecList =
    [{generator, start, []},
     {collector, start, []},
     {processor, start, []},
     {uba_reporter, start, []},
     {dashboard, start, []}],
  uba_sup:start(uba, ChildSpecList). % 启动根监督者

stop(_State) ->
  uba_sup:stop(uba).
