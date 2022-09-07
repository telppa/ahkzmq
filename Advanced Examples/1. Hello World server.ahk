; Hello World server in Autohotkey
; Binds REP socket to tcp://*:5555
; Expects "Hello" from client, replies with "World"
; 
; Author: https://github.com/telppa/ahkzmq

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.REP)
socket.bind("tcp://*:5555")

loop
{
  ; Wait for next request from client
  message := socket.recv_string()
  ToolTip Server received request: %message%, 500, 500
  
  ; Do some 'work'
  Sleep 1
  
  ; Send reply back to client
  socket.send_string("World")
}

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk