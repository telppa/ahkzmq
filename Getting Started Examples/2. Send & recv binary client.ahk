; Send & recv binary - client
; This example shows how to send and receive binary data.
; There is no limit to the size of the data, but if it is large, it should usually be sliced and sent.

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.REQ)
socket.connect("tcp://localhost:5555")

FileRead bin, *c bin.ico               ; get data of bin.ico
FileGetSize bin_size, bin.ico          ; get size of bin.ico

loop 10000
{
  socket.send_binary(bin, bin_size)    ; send to server
  msg := socket.recv_string()
}

MsgBox %msg%

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk