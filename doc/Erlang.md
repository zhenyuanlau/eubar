# 快学 Erlang
Erlang -- 一种新的解决问题的思维方式, 一个强大的工具箱(并发支持/分布式支持/容错支持).

快乐学习 Erlang!

## 准备
[[Erlang.excalidraw]]

### 环境

#### 安装

```bash
asdf plugin-add erlang
asdf install erlang latest # erl/erlc/escript/dialyzer
asdf global erlang 25.0 # .tool-versions
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

```

### 编译

```bash
erlc user_default.erl
```

### 运行

```bash
erl +Wi -noshell -pa ebin/ -s quick start -s init stop
```


## 语法速记

> 想想英语.

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

% 函数调用 Module:Function(Arguments)

io:format("Hello Erlang!~n").

% 匿名函数

F = fun(X) -> io:format("~w~n", [X]) end.

F(42).


% 创建进程

[spawn(fun () -> timer:sleep(700), io:format("Erlang!~n") end) || X <- [1,2,3]].


% 发送消息

self() ! {message, "Hello, Erlang Shell!"}.

% 接收消息

flush().

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

f().


```

### 结构式

Erlang 的结构式包含模块的属性和函数定义.

```erlang
% quick.erl

% 模块

% 模块属性

% -Name(Attribute).

-module(quick).

% 导出函数
-export([start/0]).

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

-module(quick).

```


### 语法特性

```erlang

% 变量名必须首字母大写

L = [1, 2, 3, 4, 5].

```


## 一个 UBA 应用

[[UBA.excalidraw]]

## 函数式编程
速记, M:F(A) 和 M:F/A.

### 原则/思维
```erlang

% 不可变性

% 引用透明性

% 递归思维

```


### 模块
模块是一个具名文件, 包含一组函数(可能还有记录/宏).

`erlang` 模块包含一组 `BIF` 函数, 被 `erl` 预先加载.

```erlang
% $HOME/.erlang.d/user_default.erl

-module(user_default).
-export([clear/0]).

clear() ->
  io:format(os:cmd(clear)).

```

```erlang

% 记录
-record(user, {id, name, age }).

% 宏
-define(PI, 3.14).

```

### 函数

```erlang

% 具名函数

hello() ->
	io:format("Hello Erlang!~n").


% 匿名函数

F = fun (X) -> 2 * X end.

F(2).

% 递归函数

double([H|T]) -> [2*H|double(T)];
double([])    -> [].


% 高阶函数(映射/过滤/折叠)

L = [1, 2, 3, 4, 5].

lists:map(F, L).

lists:filter(fun (X) -> X rem 2 =:= 0 end, L).
lists:zip(L, L)

```


### 模式匹配
灵活 && 完备.

```erlang

% 绑定变量

N = 42.

% 提取数据

L = [1, 2, 3, 4, 5].

[H|T] = L.


% 选择分支

start() ->
	receive
		event ->
			io:format("receive an event.");
		_ ->
			io:format("unknown.")
	end.


```


### 类型系统

```erlang
% 数据类型

%% 元组 {E₁, E₂, ..., Eₙ}

Point = {0, 0}.

%% 带标记的元组

Distance = {km, 3}.

{Unit, N} = Distance.

Event = {event, ["rabbit", "eat", "carrot"]}.

{T, E} = Event.

%% 列表 [E₁, E₂, ..., Eₙ]

L = [1, 2, 3, 4, 5].

[H|T] = L.
LX = [1|L].

%% 列表推导式

CX = [true, false, 0, "abc"].

AX = [ X || X <- CX, is_atom(X)].

% 字符串底层是列表或位串

erlang:is_list("string").


% 类型检测

% erlang:is_*

is_atom(true). % true

is_list("abc"). % true

is_bitstring(<<"abc">>). % true

% 类型转换

% erlang:*_to_*

erlang:list_to_integer("123").

% 类型定义


```


## 并发编程

```erlang

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

```bash

$ erl -sname collector

(collector@zmbp)1> register(shell, self()).


$ erl -sname generator

(generator@zmbp)2> register(shell, self()).

```

```bash
(generator@zmbp)1> net_kernel:connect_node(collector@zmbp).
true
(generator@zmbp)1> {shell, collector@zmbp} ! {hello, from, self()}.
{hello,from,<0.87.0>}


(collector@zmbp)10> flush().
Shell got {hello,from,<9637.87.0>}
ok

```
