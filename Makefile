.PHONY: clean compile console

clean:
	@rm -fr ebin/*.beam erl_crash.dump
compile: clean src/*.erl
	@erl -make
console:
	@erl -pa ebin/
