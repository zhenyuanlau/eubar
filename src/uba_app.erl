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

-spec start(StartType :: term(), StartArgs :: term()) -> {ok, pid()}.
start(_StartType, _StartArgs) ->
  ChildSpecList =
    [
      child_spec(generator),
      child_spec(collector),
      child_spec(processor),
      child_spec(uba_reporter),
      child_spec(dashboard)],
  uba_sup:start(uba, ChildSpecList). % 启动根监督者

-spec stop(State :: term()) -> ok.
stop(_State) ->
  uba_sup:stop(uba).

child_spec(Module) ->
  {Module, start, []}.
