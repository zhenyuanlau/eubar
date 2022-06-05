-module(uba_sinker).

-behaviour(gen_event).

-export([init/1, handle_event/2, handle_call/2]).

-include("uba.hrl").

init([]) ->
  mnesia:create_schema([node()]),
  mnesia:start(),
  mnesia:create_table(event, [{attributes, record_info(fields, event)}]),
  mnesia:wait_for_tables([event], 5000),
  {ok, []}.

handle_event(Event, _State) ->
  error_logger:info_msg("sinker: ~p~n", [Event]),
  Fun = fun() -> mnesia:write(Event) end,
  mnesia:activity(transaction, Fun),
  {ok, []}.

handle_call(Request, State) ->
  {ok, Request, State}.
