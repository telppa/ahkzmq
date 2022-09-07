; Send & recv multi frame string - server

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.REP)
socket.bind("tcp://*:5555")

loop 10000
{
  ; the third parameter is false, which means that the multi-frame message are stored as array
  msg := socket.recv_string(, , false)
  
  socket.send_string("frame11111", zmq.SNDMORE)
  socket.send_string("frame22222")
}

MsgBox % msg.1
MsgBox % msg.2
MsgBox % msg.3

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk