; Reading from multiple sockets
; This version uses zmq.Poller()
; 
; Author: https://github.com/telppa/ahkzmq

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()

; Connect to task ventilator
; 连接任务分发器
receiver := context.socket(zmq.PULL)
receiver.connect("tcp://localhost:5557")

; Connect to weather server
; 连接气象更新服务
subscriber := context.socket(zmq.SUB)
subscriber.connect("tcp://localhost:5556")
subscriber.setsockopt_string(zmq.SUBSCRIBE, "10001 ") ; filter = "10001 "

; Initialize poll set
; 初始化轮询器
poller := zmq.poller([[receiver, zmq.POLLIN]
                    , [subscriber, zmq.POLLIN]])

; Process messages from both sockets
loop
{
  socks := poller.poll()
  
  if (socks[1])
  {
    times++
    ToolTip % "tasks: " times " - " receiver.recv_string(), 500, 500, 1
  }
  
  if (socks[2])
    ToolTip % "weather: " subscriber.recv_string(), 500, 550, 2
}

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk