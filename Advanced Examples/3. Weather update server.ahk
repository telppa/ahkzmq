; Weather update server
; Binds PUB socket to tcp://*:5556
; Publishes random weather updates

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.PUB)
socket.bind("tcp://*:5556")

loop
{
  Random zipcode, 1, 100000
  Random temperature, -80, 135
  Random relhumidity, 10, 60
  
  update := zipcode " " temperature " " relhumidity
  socket.send_string(update)
}

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk