; Task ventilator
; Binds PUSH socket to tcp://localhost:5557
; Sends batch of tasks to workers via that socket
; 
; Author: https://github.com/telppa/ahkzmq

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()

; Socket to send messages on
sender := context.socket(zmq.PUSH)
sender.bind("tcp://*:5557")

; Socket with direct access to the sink: used to synchronize start of batch
sink := context.socket(zmq.PUSH)
sink.connect("tcp://localhost:5558")

ToolTip Press Enter when the workers and sink are ready
KeyWaitAny()
ToolTip Sending tasks to workers...

; The first message is "0" and signals start of batch
; 通知 sink 开工
sink.send_string("0")

; Send 100 tasks
; 分配100个任务给 worker
total_msec := 0
loop 100
{
  ; Random workload from 1 to 100 msecs
  Random workload, 1, 100
  total_msec += workload
  
  sender.send_string(workload)
}
MsgBox % "Total expected cost: " total_msec "ms"

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk

KeyWaitAny()
{
    Input SingleKey, L1, {LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{CapsLock}{NumLock}{PrintScreen}{Pause}
    return
}