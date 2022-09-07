# ahkzmq
Autohotkey bindings for ZeroMQ

## What is ZeroMQ ?
In short, it is a universal messaging library that can transfer message between threads, processes, programming languages, operating systems, networks.

It can transfer any kind of message, such as numbers, text, binary, etc., and has no size limit.

It has various modes, such as request/reply, publish/subscribe, push/pull, etc., and can easily implement 1-to-1, 1-to-many, many-to-many and other kinds of transmission.

It is very fast, the AHK version can send 823000 messages per second in 10-byte size in push/pull mode on the R7 5800H processor.

That's 10+ times faster than SendMessage (which usually only transmits numbers).

The C language version is even faster, estimated to be 10+ times faster than the AHK version.

## ZeroMQ 是什么？
简单说，它是一个通用消息传递库，可以用简洁的代码在不同媒介间传输信息，例如线程间、进程间、不同编程语言间、不同操作系统间、不同的网络环境间等等。

它可以传递任何形式的信息，例如数字、文字、二进制等，并且没有大小限制。

它模式多样，常用的有 请求/回复、发布/订阅、推送/拉取等，可轻松实现 1对1、1对多、多对多等各式传输。

它非常高效， AHK 版本在 R7 5800H 处理器上，推送/拉取模式下，10字节大小的信息每秒可发送约82.3w条。

速度大概是 SendMessage 的10+倍（后者通常还只能传输数字）。

其 C 语言版本速度则更快，预估是 AHK 版本的10+倍。

## 如何使用
[下载解压并运行示例](https://github.com/telppa/ahkzmq/archive/refs/heads/main.zip "实时更新")

目录 | 内容
------------- | -------------
Getting Started Examples | 入门示例
Advanced Examples | 进阶示例
ZeroMQ | 库文件
test | 功能及性能测试

## 更多介绍看这里
https://www.autoahk.com/archives/43622
