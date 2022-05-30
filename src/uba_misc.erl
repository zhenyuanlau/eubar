-module(uba_misc).

-export([start/0, stop/0, db_create/0, db_migrate/0]).

-include("include/records.hrl").

start() ->
  db_create(),
  db_migrate(),
  application:start(mnesia),
  application:start(uba).

stop() ->
  init:stop().

db_create() ->
  mnesia:create_schema([node()]).

db_migrate() ->
  mnesia:start(),
  mnesia:create_table(event_view, [{attributes, record_info(fields, event_view)}]),
  mnesia:stop().
