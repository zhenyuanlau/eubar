# Demo 应用

一个简单的用户行为分析应用的规格说明.

## 功能特性

1. Ad-Hoc
2. Dashboard

## 项目结构

uba_app 负责系统的启动或停止
uba_sup 监督所有进程
uba.app.src 应用的元数据

## 服务组件

### generator(数据生成器)
### collector(数据采集器)
### processor(数据处理器)
### reporter(报表服务器)
### dashboard(看板服务器)

## 数据模型

```erlang
% event
% user
```

## 接口设计

```erlang
% generator

% collector

% processor

% reporter

% dashboard

```
