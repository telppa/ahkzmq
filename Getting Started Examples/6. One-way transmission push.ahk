; One-way transmission 示例 - 发送端
; 本例演示 PUSH/PULL 模式。
; 注意：该模式下，传输是单向的， 只能 PUSH 端发送 PULL 端接收。
; 可以是多个 PUSH 往一个 PULL 发送，也可以是一个 PUSH 往多个 PULL 发送，但是传输方向永远是 PUSH 到 PULL。
; 本例必须先启动 PULL 端，再启动 PUSH 端，否则将出现“慢连接”的情况。

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
sender := context.socket(zmq.PUSH)
sender.bind("tcp://*:5557")

; bind 和 connect 操作并不会产生阻塞。
; 这里的休眠是为了等待所有的 PULL 端都连接成功。
; 假设 PULL1 花了5ms 连接上， PULL2 花了8ms。
; 当 PULL1 连接上而 PULL2 尚未连接的3ms间，消息很可能就发完了，表现就是 PULL2 收不到任何消息。
; 所以本例需要 PULL 端先启动，并且 PUSH 端在这里进行休眠，等待所有 PULL 端连接成功。
Sleep 1000

loop 500
  sender.send_string("OK")

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk