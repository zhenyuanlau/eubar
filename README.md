Erlang Spec
=====

Learn
-----

[快学 Erlang](https://github.com/zhenyuanlau/erlang-spec/blob/main/resources/Erlang.md)

Dev
-----
    $ make dev
    > uba_misc:db_create().
    > uba_misc:db_migrate().

    > uba_misc:start().
    > observer:start().
    > uba_reporter:query().


Doc
-----
    > edoc:application(uba, ".", []).
