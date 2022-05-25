# UBA 应用

UBA(User Behavior Analysis), 用户行为数据分析应用的规格说明.

## 功能特性

1. 通过 Ad-Hoc 命令, 查询统计结果
2. 通过 Dashboard 获取事件分析数据

## 服务组件

### generator(数据生成器)
### collector(数据采集器)
### processor(数据处理器)
### reporter(报表服务器)
### dashboard(看板服务器)

## 数据模型

```erlang
-record(event, {uid, key, time}).
-record(user, {id, name, mobile }).
```

## 接口设计

```erlang
% generator

% collector

% processor

% reporter

% dashboard

```
