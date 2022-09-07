; Hello World client in Autohotkey
; Connects REQ socket to tcp://localhost:5555
; Sends "Hello" to server, expects "World" back
; 
; Author: https://github.com/telppa/ahkzmq

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.REQ)
socket.connect("tcp://localhost:5555")

; Do 10 requests, waiting each time for a response
loop 10
{
  socket.send_string("Hello")
  
  ; Get the reply.
  message := socket.recv_string()
  ToolTip Client received reply %A_Index%: %message%, 500, 550
}

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk