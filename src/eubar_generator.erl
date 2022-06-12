-module(eubar_generator).

-behaviour(gen_statem).

-include("eubar.hrl").

-export([start_link/0, init/1, callback_mode/0]).
-export([emit/3]).

start_link() ->
  gen_statem:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
  State = emit,
  Counter = 0,
  EventList = {visit, click, double_click, submit},
  {ok, State, {Counter, EventList}}.

callback_mode() ->
  [state_functions, state_enter].

emit(enter, _OldState, Data) ->
  gen_statem:cast(?MODULE, emit),
  {keep_state, Data};
emit(cast, _OldState, {Counter, EventList}) ->
  error_logger:info_msg("emit event ~p~n", [Counter]),
  Event =
    #event{evt_id = Counter,
           evt_key = element(Counter rem tuple_size(EventList) + 1, EventList)},
  gen_server:call(eubar_collector, {event, Event}),
  {keep_state, {Counter + 1, EventList}, [{state_timeout, 7000, emit}]};
emit(state_timeout, emit, Data) ->
  gen_statem:cast(?MODULE, emit),
  {keep_state, Data}.
