; 单向传输示例 - 发送端
; 本例演示 PUSH/PULL 模式。
; 注意：该模式下，传输是单向的， 只能 PUSH 端发送 PULL 端接收。
; 可以是多个 PUSH 往一个 PULL 发送，也可以是一个 PUSH 往多个 PULL 发送，但是传输方向永远是 PUSH 到 PULL。
; 本例必须先启动 PULL 端，再启动 PUSH 端，否则将出现“慢连接”丢消息的情况。

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
sender := context.socket(zmq.PUSH)
sender.bind("tcp://*:5557")

; bind() 和 connect() 操作并不会产生阻塞。
; 这里的休眠是为了等待所有的 PULL 都连接成功。
; 否则因为消息发送的速度非常快，剩下的 PULL 还没连接上，消息就已经全部发送给第一个连接上的 PULL 了。
Sleep 1000

; 如果有2个 PULL 连接，则每个 PULL 将收到250条消息。
loop 500
  sender.send_string("OK")

ExitApp

#Include %A_LineFile%\..\..\..\ZeroMQ\ZeroMQ.ahk