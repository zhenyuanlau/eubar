.PHONY: clean compile start

compile:
	@cp src/uba.app.src ebin/uba.app
	@erl -make
start: compile
	@erl -sname uba -boot start_sasl -pa ebin/ -config config/elog.config
clean:
	@rm -fr ebin/*.beam erl_crash.dump logs/* ebin/*.app
