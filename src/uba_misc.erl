-module(uba_misc).

-export([start/0, db_create/0, db_migrate/0]).

-include("include/data.hrl").

start() ->
  application:start(mnesia),
  application:start(uba).

db_create() ->
  mnesia:create_schema([node()]).

db_migrate() ->
  mnesia:start(),
  mnesia:create_table(event_view, [{attributes, record_info(fields, event_view)}]),
  mnesia:stop().
