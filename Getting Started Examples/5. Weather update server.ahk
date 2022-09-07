; Weather update - server

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.PUB)
socket.bind("tcp://*:5556")

loop
{
  Random zipcode, 1, 100000                         ; randomly generate zipcode from 1-100000
  Random temperature, -80, 135                      ; randomly generate temperature
  Random relhumidity, 10, 60                        ; randomly generate relhumidity
  
  update := zipcode " " temperature " " relhumidity ; generate weather information
  socket.send_string(update)                        ; publish it
}

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk