%%%-------------------------------------------------------------------
%% @doc eubar top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(eubar_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%% sup_flags() = #{strategy => strategy(),         % optional
%%                 intensity => non_neg_integer(), % optional
%%                 period => pos_integer()}        % optional
%% child_spec() = #{id => child_id(),       % mandatory
%%                  start => mfargs(),      % mandatory
%%                  restart => restart(),   % optional
%%                  shutdown => shutdown(), % optional
%%                  type => worker(),       % optional
%%                  modules => modules()}   % optional
init([]) ->
    SupFlags = #{strategy => one_for_all,
                 intensity => 0,
                 period => 1},
    ChildSpecs = [child_spec(Module) || Module <- [eubar_collector, eubar_reporter, eubar_processor, eubar_generator]],
    {ok, {SupFlags, ChildSpecs}}.

%% internal functions
child_spec(Module) ->
  Name = Module,
  StartFunc = {Module, start_link, []},
  RestartType = permanent,
  ShutdownTime = 2000,
  ProcessType = worker,
  Modules = [Module],
  {Name, StartFunc, RestartType, ShutdownTime, ProcessType, Modules}.
