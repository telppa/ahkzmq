; Simple message queuing broker
; Same as request-reply broker but using "zmq.proxy"
; 
; Author: https://github.com/telppa/ahkzmq
; 此例是 “6. Request-reply broker.ahk” 的另一种实现

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()

frontend := context.socket(zmq.ROUTER)
frontend.bind("tcp://*:5559")

backend := context.socket(zmq.DEALER)
backend.bind("tcp://*:5560")

zmq.proxy(frontend, backend)

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk