; Task sink - design 2
; Adds pub-sub flow to send kill signal to workers
; 
; Author: https://github.com/telppa/ahkzmq
; 此例应与 “4. Parallel task ventilator.ahk” 联合使用

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()

; Socket to receive messages on
receiver := context.socket(zmq.PULL)
receiver.bind("tcp://*:5558")

; Socket for worker control
controller := context.socket(zmq.PUB)
controller.bind("tcp://*:5559")

; Wait for start of batch
; 等待开始信号
receiver.recv_string()

; Process 100 confirmations, calculate and report duration of batch
; 收集100个任务的回应并计时
tstart := A_TickCount
loop 100
  receiver.recv_string()
MsgBox % "Total elapsed time: " A_TickCount - tstart "ms"

; Send kill signal to workers
controller.send_string("KILL")

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk