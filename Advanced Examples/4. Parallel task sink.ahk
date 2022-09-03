; Task sink
; Binds PULL socket to tcp://localhost:5558
; Collects results from workers via that socket
; 
; Author: https://github.com/telppa/ahkzmq

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()

; Socket to receive messages on
receiver := context.socket(zmq.PULL)
receiver.bind("tcp://*:5558")

; Wait for start of batch
; 等待开始信号
receiver.recv_string()

; Process 100 confirmations, calculate and report duration of batch
; 收集100个任务的回应并计时
tstart := A_TickCount
loop 100
  receiver.recv_string()
MsgBox % "Total elapsed time: " A_TickCount - tstart "ms"

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk