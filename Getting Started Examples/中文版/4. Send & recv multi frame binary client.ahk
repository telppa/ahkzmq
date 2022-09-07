; 收发多帧二进制示例 - 客户端
; 本例演示如何收发多帧二进制消息。

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.REQ)
socket.connect("tcp://localhost:5555")

FileRead bin, *c bin.ico
FileGetSize bin_size, bin.ico

loop 10000
{
  socket.send_string("frame 1 is string", zmq.SNDMORE) ; 第一帧是字符串
  socket.send_binary(bin, bin_size)                    ; 第二帧是二进制内容（bin.ico）
  msg := socket.recv_string()
}

MsgBox %msg%

ExitApp

#Include %A_LineFile%\..\..\..\ZeroMQ\ZeroMQ.ahk