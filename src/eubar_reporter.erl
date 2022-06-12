-module(eubar_reporter).

-behaviour(gen_server).

-export([query/0]).
-export([start_link/0, init/1, handle_call/3, handle_cast/2]).

-include_lib("stdlib/include/qlc.hrl").

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init(_Args) ->
  {ok, state}.

query() ->
  gen_server:call(?MODULE, query).

handle_call(Request, _From, _State) ->
  case Request of
    query ->
      Reply = do(qlc:q([X || X <- mnesia:table(event)])),
      {reply, Reply, _State};
    _Other ->
      {reply, bad_request, _State}
  end.

handle_cast(Request, _State) ->
  {noreply, gen_server:call(?MODULE, Request)}.

do(Q) ->
  F = fun() -> qlc:e(Q) end,
  {atomic, Val} = mnesia:transaction(F),
  Val.
