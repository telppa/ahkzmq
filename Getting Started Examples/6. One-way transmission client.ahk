; One-way transmission 示例 - 客户端
; 本例演示 PUSH/PULL 模式。
; 注意：该模式下，传输是单向的， 只能 PUSH 端发送 PULL 端接收。
; 可以是多个 PUSH 往一个 PULL 发送，也可以是一个 PUSH 往多个 PULL 发送，但是传输方向永远是 PUSH 到 PULL。

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
sender := context.socket(zmq.PUSH)
sender.bind("tcp://*:5557")

loop 10000
  sender.send_string("OK")

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk