%%
%% 应用模块 <application-name>_app.erl
%% 负责启动 <根监督者>
%%
%% 在运行时, 应用就是一棵由监督者和工作者进程共同构成的进程树, 树根就是监督者.
%%
%% -behaviour(application).
%%
-module(uba_app).

-include("include/data.hrl").

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
  mnesia:wait_for_tables([event_view], 5000),
  uba_sup:start_link(). % 启动根监督者

stop(_State) ->
  ok.
