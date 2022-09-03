; Request-reply service in Autohotkey
; Connects REP socket to tcp://localhost:5560
; Expects "Hello" from client, replies with "World"

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.REP)
socket.connect("tcp://localhost:5560")

loop
{
  message := socket.recv_string()
  ToolTip Received request: %message%
  socket.send_string("World")
}

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk