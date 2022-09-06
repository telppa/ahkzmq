; 天气订阅示例 - 客户端
; 本例演示从服务端接收指定地区的天气信息。
; 本例使用 PUB/SUB 模式，又叫 发布/订阅 模式。
; 注意：该模式下，客户端必须使用 setsockopt 设置需要订阅的内容，否则将收不到任何消息。
; 订阅可以多次设置，也可以设置空值表示订阅全部内容，还可以设置不订阅的内容。
; 如果没有与 PUB 端进行同步的话，可能会因为“慢连接”丢失部分开始的消息。
; 进阶示例13 为进行同步的示例。

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.SUB)
socket.connect("tcp://localhost:5556")

filter := "10001 "
socket.setsockopt_string(zmq.SUBSCRIBE, filter) ; 设置接收 “10001 ” 开头的消息

loop 5                                          ; 接收5条邮编为 10001 地区的消息
  MsgBox % socket.recv_string()

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk