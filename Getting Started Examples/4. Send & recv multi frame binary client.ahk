; Send & recv multi frame binary - client
; This example shows how to send and receive multi-frame binary messages.

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
  socket.send_string("frame 1 is string", zmq.SNDMORE) ; frame 1 is string
  socket.send_binary(bin, bin_size)                    ; frame 2 is binary (bin.ico)
  msg := socket.recv_string()
}

MsgBox %msg%

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk