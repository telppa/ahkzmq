; 收发多帧文本示例 - 服务端

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.REP)
socket.bind("tcp://*:5555")

loop 10000
{
  msg := socket.recv_string(, , false)          ; 第三个参数为 false 的 recv_string() 表示将多帧消息存为数组
  socket.send_string("frame11111", zmq.SNDMORE)
  socket.send_string("frame22222")
}

MsgBox % msg.1
MsgBox % msg.2
MsgBox % msg.3

ExitApp

#Include %A_LineFile%\..\..\..\ZeroMQ\ZeroMQ.ahk