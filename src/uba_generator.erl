-module(uba_generator).

-behaviour(gen_statem).

-export([start_link/0, init/1, callback_mode/0]).
-export([emit/3]).

start_link() ->
  gen_statem:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
  State = emit,
  Data = 0,
  {ok, State, Data}.

callback_mode() ->
  [state_functions, state_enter].

emit(enter, _OldState, Data) ->
  gen_statem:cast(?MODULE, emit),
  {keep_state, Data + 1};
emit(cast, _OldState, Data) ->
  gen_event:notify(uba_collector, emit),
  {keep_state, Data + 1, [{state_timeout, 5000, emit}]};
emit(state_timeout, emit, Data) ->
  gen_statem:cast(?MODULE, emit),
  {keep_state, Data + 1}.
