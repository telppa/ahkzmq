; Simple request-reply broker
; 
; Author: https://github.com/telppa/ahkzmq

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

; Prepare our context and sockets
context := zmq.context()
frontend := context.socket(zmq.ROUTER)
backend := context.socket(zmq.DEALER)
frontend.bind("tcp://*:5559")
backend.bind("tcp://*:5560")

; Initialize poll set
poller := zmq.poller([[frontend, zmq.POLLIN]
                    , [backend, zmq.POLLIN]])

; Switch messages between sockets
loop
{
  socks := poller.poll()
  
  if (socks[1])
  {
    multipart := frontend.recv_multipart()
    backend.send_multipart(multipart)
  }
  
  if (socks[2])
  {
    multipart := backend.recv_multipart()
    frontend.send_multipart(multipart)
  }
}

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk