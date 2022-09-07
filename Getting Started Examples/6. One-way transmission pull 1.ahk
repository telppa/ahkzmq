; One-way transmission - pull

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
receiver := context.socket(zmq.PULL)
receiver.connect("tcp://localhost:5557")

loop 250
  msg := receiver.recv_string()

MsgBox %msg%

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk