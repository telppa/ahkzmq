; Send & recv string - server

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.REP) ; create a socket with REP
socket.bind("tcp://*:5555")       ; bind to endpoint

loop 10000
{
  msg := socket.recv_string()     ; receiving request from client
  socket.send_string("World")     ; send "World" to client
}

MsgBox Server received request %msg%

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk