.PHONY: clean compile dev prod

compile:
	@cp src/uba.app.src ebin/uba.app
	@erl -make
dev: compile
	@erl -sname uba -boot start_clean -pa ebin/ -config config/debug.config -mnesia dir '"tmp/db"'
prod: compile
	@erl -sname uba -boot start_sasl -pa ebin/ -config config/elog.config -mnesia dir '"tmp/db"'
db_create:
	@erl -sname uba -mnesia dir '"tmp/db"' -noshell -eval 'mnesia:create_schema([node()])' -s erlang halt
clean:
	@rm -fr ebin/*.beam erl_crash.dump logs/* ebin/*.app tmp/db
