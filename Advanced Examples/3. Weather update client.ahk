; Weather update client
; Connects SUB socket to tcp://localhost:5556
; Collects weather updates in zipcode
; 
; Author: https://github.com/telppa/ahkzmq

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.SUB)
socket.connect("tcp://localhost:5556")

; Subscribe to zipcode, default is NYC, 10001
filter := "10001 "
socket.setsockopt_string(zmq.SUBSCRIBE, filter)

; Process 5 updates
loop 5
  MsgBox % socket.recv_string()

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk