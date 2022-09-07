; Request-reply client in Autohotkey
; Connects REQ socket to tcp://localhost:5559
; Sends "Hello" to server, expects "World" back
; 
; Author: https://github.com/telppa/ahkzmq

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

; Prepare our context and sockets
context := zmq.context()
socket := context.socket(zmq.REQ)
socket.connect("tcp://localhost:5559")

; Do 10 requests, waiting each time for a response
loop 10
{
  socket.send_string("Hello")
  message := socket.recv_string()
  MsgBox Received reply %A_Index% %message%
}

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk