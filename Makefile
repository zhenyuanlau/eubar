.PHONY: clean compile start s

compile:
	@cp src/uba.app.src ebin/uba.app
	@erl -make
start: compile
	@erl -sname uba -boot start_sasl -pa ebin/ -config config/elog.config
s: compile
	@erl -sname uba -boot start_clean -pa ebin/ -config config/debug.config
clean:
	@rm -fr ebin/*.beam erl_crash.dump logs/* ebin/*.app
