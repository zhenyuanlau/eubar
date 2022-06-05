.PHONY: clean compile dev prod doc release boot

compile:
	@cp src/uba.app.src ebin/uba.app
	@erl -make
dev: compile
	@erl -sname uba -boot start_clean -pa ebin/ -config config/debug.config -mnesia dir '"tmp/db"' -eval 'application:start(uba)'
prod: compile
	@erl -sname uba -boot start_sasl -pa ebin/ -config config/elog.config -mnesia dir '"tmp/db"' -eval 'application:start(uba)'
db_create:
	@erl -sname uba -mnesia dir '"tmp/db"' -noshell -eval 'mnesia:create_schema([node()])' -s erlang halt
doc:
	@rm -fr doc/
	@erl -noshell -eval 'edoc:application(uba, ".", [])' -s erlang halt
release: compile
	@cp src/uba.rel.src uba.rel
	@erl -noshell -eval 'systools:make_script("uba", [{path, ["ebin/"]}, {outdir, "build"}])' -s erlang halt
	@erl -noshell -eval 'systools:make_tar("uba", [{path, ["ebin/", "build/"]}, {outdir, "build"}])' -s erlang halt
	@rm uba.rel
clean:
	@rm -fr ebin/* erl_crash.dump logs/* tmp/db ttb_last_config build/*
shell: release
	@erl -sname uba -pa ebin/ -pa build/ -boot uba -config config/debug.config
