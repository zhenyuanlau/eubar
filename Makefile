.PHONY: clean compile dev prod

compile:
	@cp src/uba.app.src ebin/uba.app
	@erl -make
dev: compile
	@erl -sname uba -boot start_clean -pa ebin/ -config config/debug.config
prod: compile
	@erl -sname uba -boot start_sasl -pa ebin/ -config config/elog.config
clean:
	@rm -fr ebin/*.beam erl_crash.dump logs/* ebin/*.app doc/
