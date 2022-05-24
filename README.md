Erlang Spec
=====

Config
-----
```erlang
% $HOME/.erlang.d/user_default.erl

-module(user_default).
-export([clear/0]).

clear() ->
  io:format(os:cmd(clear)).

% $HOME/.erlang

{ok,[[HOME_PATH]]} = init:get_argument(home).

USER_DEFAULT_PATH = filename:join([HOME_PATH, ".erlang.d", "user_default"]).

code:load_abs(USER_DEFAULT_PATH).

```

Build
-----
    $ erl -make

Usage
-----
    $ erl -pa ebin/

    $ uba_app:start().
    $ reporter:call(query).
