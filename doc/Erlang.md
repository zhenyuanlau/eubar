# 快学 Erlang

> Erlang 不是银弹!

Erlang -- 一种新的解决问题的思维方式, 一个强大的工具箱(函数式/并发/分布式/容错).

快乐学习 Erlang!

## 设计哲学

>
>编程模型基于对现实世界的观察.
>
>Erlang 程序模拟了人类如何思考, 如何交互.
>


## 准备
具备`命令式编程语言`的知识.

### 环境

#### 安装

```bash
asdf plugin-add erlang
asdf install erlang latest
asdf global erlang 25.0 # .tool-versions

# erl
# erlc
# escript
# dialyzer/typer 类型
```

#### 配置

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


### REPL
编辑(Emacs 快捷键/Tab 自动补全)/编译/运行 Erlang 代码块.

管理本地/远程作业.

*注: Erlang Shell  只能执行合法的 Erlang 表达式.*

```bash
$ erl

Eshell V13.0  (abort with ^G)

User switch command
 --> h
  c [nn]            - connect to job
  i [nn]            - interrupt job
  k [nn]            - kill job
  j                 - list all jobs
  s [shell]         - start local shell
  r [node [shell]]  - start remote shell
  q                 - quit erlang
  ? | h             - this message
 --> c

help().

f().
flush().

```

### 编译

```bash
erlc user_default.erl

$ erl
c(user_default).

```

### 运行

```bash
erl +Wi -noshell -pa ebin/ -s quick start -s init stop
```


## 语法速记

> 想想英语.

相对而言, Erlang 的语法是简单的.

### 表达式

> 请记住, Erlang 里的一切都是表达式, 而表达式都具有值.

Erlang 的表达式包含
- if ... end
- case ... of ... end
- begin ... end
- fun() -> ... end
- try ... of ... catch ... end
- ...

```erlang

% 模式匹配(变量绑定)

N = 42.

% 算术表达式

X = 42.

% 逻辑表达式

true and true.

false or true.

true xor false.

not (true and true).

% 关系表达式

1 < 1.

1 > 1.

1 >= 1.

% 列表推导式

[X * 2 || X <- [1, 2, 3]].

% 块表达式

begin
X = 1,
Y = 2,
Z = X + Y
end.

% if 表达式, 又称 卫模式
X = 1.
if X =:= 1.0 ->
	io:format("1 =/= 1.0.~n");
   true ->
	io:format("It's true branch~n")
end.

% case 表达式

case X =:= 1.0 of
	true ->
	  io:format("It's true~n");
	false ->
	  io:format("It's false~n")
end.

```

### 结构式

Erlang 的结构式包含模块的属性和函数定义.

```erlang
% user_default.erl

% 模块

% 模块属性

% -Name(Attribute).

-module(user_default).

% 导出函数
-export([clear/0]).

% 包含文件
-include("include/data.hrl").

% 定义宏

-define(PI, 3.14).

% 宏控制流
-undef(PI).

% 定义函数

% Name(Args) -> Body.

start() ->
    S = "Hello, Erlang!~n",
	io:format(S).

```

### 分隔符/终结符

```erlang

% 逗号(,) 分隔表达式

X = 1, Y = 2, Z = X + Y.

% 分号(;) 分隔表达式的分支, 而非终结表达式分支

X = 1.
if X =:= 1.0 ->
	io:format("1 =/= 1.0.~n");
   true ->
	io:format("It's true branch~n")
end.

% 分号(;) 分隔函数的子句

fac(N) when N == 0 -> 1;
fac(N) when N > 0 -> N * fac(N - 1).

% 句点(.) 在 Erlang Shell 中终结表达式

X.

% 句点(.) 在 Erlang 代码中终结结构式

-module(user_default).

```


### 语法特性

```erlang
% 无块注释


% 变量名必须首字母大写

N = 42.

List = [1, 2, 3, 4, 5].

Tuple = { tag, 1, 2}.


% 操作符

%% 精确相等性

1 =:= 1.0.

1 =/= 1.

%% 不精确相等性

1 /= 1
1 == 1.0.

%% 小于等于

1 =< 1.

%% 短路操作符

false andalso true.

true orelse false.


%% 列表推导式

[100 * N || N <- [1, 2, 3, 4, 5, 6], N rem 2 =:= 0, 100 * N > 400].

%% 位语法

Color = 16#FF0000.

Pixel = <<Color:24>>.

<<R:8, G:8, B:8>> = Pixel.

R.

<<R:8, Rest/binary>> = Pixel.

% 无 for/while 循环结构, 使用递归/模式匹配

```


## 函数式编程

Erlang 不是纯粹的函数式编程语言.

### 思维

```erlang

% 声明式


% 不变性

X = 1.
X = 2. % ** exception error: no match of right hand side value 2

% 引用透明性 := 参数相同, 返回值永远相同

io:format("Rules are made to be broken~n").


% 数据转换 := 函数将输入转换成输出.

io:format("I't not a pure function~n").

% 递归思想

```

### 函数

> 函数是数据转换器.

速记, M:F(A) 和 M:F/A.

#### 匿名函数
相比具名函数, 匿名函数作参数更为简便；不能递归调用.

```erlang

% 匿名函数

F = fun(X) -> io:format("~w~n", [X]) end.

F(42).

% 匿名函数的类型是函数

F = fun (X) -> 2 * X end.

is_function(F).

is_function(F, 1).


F(2).


% 模式匹配
%% 通过模式匹配, 将实参绑定到形参

Swap = fun ({A, B}) -> {B, A} end.

Swap({1, 2}).

%% 通过模式匹配, 选择函数子句

HandleOpen = fun
	({ok, File}) -> file:read_line(File);
	({error, Reason}) -> io:format("~p~n", [Reason])
end.

HandleOpen(file:open("/tmp/dummy", read)).


```

#### 具名函数
具名函数必须定义在 `模块` 中.

```erlang

% 函数调用 Module:Function(Arguments)

io:format("Hello Erlang!~n").

apply(io, format, ["Hello Erlang!~n"]).


% 具名函数

hello() ->
	io:format("Hello Erlang!~n").

% 递归函数

double([H|T]) -> [2*H|double(T)];
double([])    -> [].

```


#### 高阶函数

> 高阶函数是函数式编程语言的精髓.

```erlang

% 能返回函数的函数

F = fun (Name) -> fun() -> io:format("~p~n", [Name]) end end.
G = F(erlang).
G().


% 高阶函数(映射/过滤/折叠)

L = [1, 2, 3, 4, 5].

lists:map(F, L).

lists:filter(fun (X) -> X rem 2 =:= 0 end, L).
lists:zip(L, L)

% 函数引用

FormatStrings= ["Hello Ruby~n", "Hello Erlang~n", "Hello Elixir~n"].

lists:foreach(fun io:format/1, FormatStrings).


```

#### 闭包

```erlang

F = fun (Name) -> fun() -> io:format("~p~n", [Name]) end end.
G = F(erlang).
G().

```

### 模式匹配
模式匹配是 Erlang 的根基；Erlang 的模式匹配灵活且完备.

#### 绑定变量

```erlang
% 通过模式绑定变量

N = 42.
42 = N.

%% 一次性绑定

[X, X] = [1, 1].
[Y, Y] = [X, 2].

% 通过模式提取数据

L = [1, 2, 3, 4, 5].

[H|T] = L.


% 匿名变量

{ok,_} = {ok, X}.


```

#### 选择分支

```erlang

% 通过模式选择表达式分支
receive
	event ->
		io:format("receive an event.");
	_ ->
		io:format("unknown.")
end.
```

#### 选择子句

```erlang

% 通过模式选择函数子句

double([H|T]) -> [2*H|double(T)];
double([])    -> [].


double([]).

double([1, 2, 3])



```

#### 控制抽象

```erlang

% 通过模式实现控制抽象
%% if/switch/for/while


% 扩展模式,卫模式

```


### 模块
模块是一个具名文件, 包含模块属性和具名函数定义.

```erlang
% $HOME/.erlang.d/user_default.erl

-module(user_default).
-export([clear/0]).

clear() ->
  io:format(os:cmd(clear)).
```

`erlang` 模块包含一组 `BIF` 函数, 被 `erl` 预先加载.

#### 函数定义

```erlang
-module(server).
-export([start/2, stop/1, call/2]).
-export([init/2]).

-spec start(atom(),_) -> {ok,pid()}.

start(Name, Args) ->
  Pid = spawn(server, init, [Name, Args]),
  register(Name, Pid),
  {ok, Pid}.

init(Mod, Args) ->
  State = Mod:init(Args),
  loop(Mod, State).

stop(Name) ->
  Name ! {stop, self()},
  receive {reply, Reply} -> Reply end.

call(Name, Msg) ->
  Name ! {request, self(), Msg},
  receive {reply, Reply} -> Reply end.

reply(To, Reply) ->
  To ! {reply, Reply}.

loop(Mod, State) ->
  receive
    {request, From, Msg} ->
      {NewState, Reply} = Mod:handle(Msg, State),
      reply(From, Reply),
      loop(Mod, NewState);
    {stop, From} ->
      Reply = Mod:terminate(State),
      reply(From, Reply)
  end.

```


#### 宏定义

```erlang

% 预定义宏

% ?MODULE/?FILE/?LINE.

-ifdef(DEBUG_MODE)
alert() ->
	io:format("Enable Debug Mode.~n").
-else.
-define(DEBUG, true).
-endif.

```

#### 元数据

```bash

$ erl

user_default:module_info().

user_default:module_info(module).
user_default:module_info(attributes).
user_default:module_info(compile).
user_default:module_info(md5).

```


### 类型系统
Erlang 没有字符串类型.

#### 内置类型

数据类型 := 值集合 + 操作集合.

```erlang
% 数据类型

%% 数值类型

42.
2#101010.
8#52.
16#2A.

%% ★ 元组 {E₁, E₂, ..., Eₙ}

Point = {0, 0}.

%% 带标记的元组

Distance = {km, 3}.

{Unit, N} = Distance.

Event = {event, ["rabbit", "eat", "carrot"]}.

Record = element(2, Event).

{T, E} = Event.


%% ★ 列表 [E₁, E₂, ..., Eₙ]

L = [1, 2, 3, 4, 5].

[H|T] = L.
LX = [1|L].

%% 列表推导式

CX = [true, false, 0, "abc"].

AX = [ X || X <- CX, is_atom(X)].

% 字符串底层是列表或位串

erlang:is_list("string").

% 二进制/位语法


% 引用

% erlang:make_ref().


```

#### 类型检测

```erlang

% erlang:is_*

is_atom(true). % true

is_list("abc"). % true

is_bitstring(<<"abc">>). % true

```

#### 类型转换

```erlang
% erlang:*_to_*

erlang:list_to_integer("123").
```


#### 类型注解

```erlang
-spec start() -> {ok,pid()}.
```


## 并发编程

>
> Erlang 的基本并发单元是进程.
>
> 要用 Erlang 编写一个并发程序, 必须确定一组用来解决问题的进程.
>
> 进程负责执行模块里定义的函数.
>
> 进程只能通过发送和接收消息来与其他进程通信.
>

### 进程

Erlang 采用 Actor 模型, 每个 Actor 都是虚拟机中的一个独立进程(无共享内存).

```erlang

% 创建进程

[spawn(fun () -> timer:sleep(700), io:format("Erlang!~n") end) || X <- [1,2,3]].


% 进程(Actor) & 消息传递

F = fun () ->
	%% 接收消息
    receive
      {From, Event} ->
        From ! Event
    end
end.

Actor = spawn(fun () -> F() end).

%% 发送消息

Actor ! { self(), "Click" }.

self() ! {message, "Hello, Erlang Shell!"}.

% 接收消息

flush().

```

### 消息

```erlang

self() ! "hi".

flush().

```


## 容错式编程
### 错误/异常
错误: 编译期错误/逻辑错误/运行时错误

异常: 出错(error)/退出(exit)/抛出(throw)

```erlang

% 错误异常

erlang:error(error).

% 退出异常
% 内部退出/外部退出

erlang:exit(exit).

% 抛出异常, 改变控制流, 不会让进程崩溃

erlang:throw(throw).

```


### 顺序程序的错误处理

```erlang
% try 表达式

try
    throw({my_exception, "Something happened"})
catch
    throw:{my_exception, Desc} ->
        io:format(standard_error, "Error: ~s~n", [Desc])
end

% catch 表达式

catch error(error).

catch exit(exit).

```


### 并发程序的错误处理

#### 链接

```erlang
F = fun() ->
		timer:sleep(5000),
		exit(reason)
	end

spawn(fun() -> F() end).

% shell 收到进程的死亡信号

% link(spawn(fun() -> F() end)).

spawn_link(fun() -> F() end).

% 捕获退出信号

process_flag(trap_exit, true).

spawn_link(fun() -> F() end).

receive X -> X end.

```

#### 监控

```erlang

F = fun() ->
		timer:sleep(5000),
		exit(reason)
	end
erlang:monitor(process, spawn(fun() -> F() end)).

flush().

```

## 分布式编程

### 节点

```bash

$ erl -sname collector

(collector@ambp)1> register(shell, self()).


$ erl -sname generator

(generator@ambp)2> register(shell, self()).

```

### 通信

```bash

(generator@ambp)1> net_kernel:connect_node(collector@ambp).
true
(generator@ambp)1> {shell, collector@ambp} ! {hello, from, self()}.
{hello,from,<0.87.0>}


(collector@ambp)10> flush().
Shell got {hello,from,<9637.87.0>}
ok

```
