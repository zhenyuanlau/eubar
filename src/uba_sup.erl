%%
%% 根监督者模块 <application-name>_sup.erl
%%
%% -behaviour(supervisor).
%%
%% 监督者规格包含重启规格和子进程规格
%%
%% 重启规格 {RestartType, MaxRestart, MaxTime}
%%
%% 重启策略 one_for_one/one_for_all/rest_for_one/simple_one_for_one
%%
%% 子进程规格 {Name, StartFunction, RestartType, ShutdownTime, ProcessType, Modules}
%%
%%
%%
-module(uba_sup).

-behaviour(supervisor).

-export([start_link/0, init/1]).

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init(_Args) ->
  RestartType = one_for_one,
  MaxRestart = 2,
  MaxTime = 36000,
  RestartTuple = {RestartType, MaxRestart, MaxTime},
  ChildSpecList = [child_spec(Module) || Module <- [uba_collector, uba_reporter, uba_processor, uba_generator]],
  {ok, {RestartTuple, ChildSpecList}}.

child_spec(Module) ->
  Name = Module,
  StartFunc = {Module, start_link, []},
  RestartType = permanent,
  ShutdownTime = 2000,
  ProcessType = worker,
  Modules = [Module],
  {Name, StartFunc, RestartType, ShutdownTime, ProcessType, Modules}.
