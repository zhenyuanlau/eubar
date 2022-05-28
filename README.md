Erlang Spec
=====

Learn
-----

[快学 Erlang](https://github.com/zhenyuanlau/erlang-spec/blob/main/doc/Erlang.md)

Demo
-----
    $ make start
    > application:start(uba).
    > whereis(uba_reporter).
    > uba_reporter:call(query).


Tool
-----

    > observer:start().
    > edoc:application(uba, ".", []).

