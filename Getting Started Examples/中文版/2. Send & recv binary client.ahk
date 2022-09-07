; 收发二进制示例 - 客户端
; 本例演示如何收发二进制数据。
; 数据大小没有限制，但如果很大，通常应该切片后再发送，即通过多条消息发送。

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.REQ)
socket.connect("tcp://localhost:5555")

FileRead bin, *c bin.ico               ; 取 bin.ico 内容
FileGetSize bin_size, bin.ico          ; 取 bin.ico 大小

loop 10000
{
  socket.send_binary(bin, bin_size)    ; 将二进制内容（bin.ico）发给服务端
  msg := socket.recv_string()
}

MsgBox %msg%

ExitApp

#Include %A_LineFile%\..\..\..\ZeroMQ\ZeroMQ.ahk