; Send multi frame string - 客户端
; 本例演示如何收发多帧文本消息。
; 注意：例2中提到的切片是指多条消息，而本例是一条消息包含多帧。

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.REQ)
socket.connect("tcp://localhost:5555")

loop 10000
{
  socket.send_string("服务端会收到", zmq.SNDMORE) ; 发送第一帧
  socket.send_string("一条包含三帧", zmq.SNDMORE) ; 发送第二帧
  socket.send_string("的消息")                    ; 发送第三帧。此时一条消息的发送才算完成，因此并不违反例1提到的顺序规则
  msg := socket.recv_string()                     ; 不带参数的 recv_string() 会把多帧消息合并成一个变量
}

MsgBox %msg%

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk