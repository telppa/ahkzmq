; 天气订阅示例 - 服务端

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.PUB)
socket.bind("tcp://*:5556")

loop
{
  Random zipcode, 1, 100000                         ; 从 1-100000 随机生成邮编
  Random temperature, -80, 135                      ; 随机生成温度
  Random relhumidity, 10, 60                        ; 随机生成湿度
  
  update := zipcode " " temperature " " relhumidity ; 生成 “邮编 温度 湿度” 组成的天气信息
  socket.send_string(update)                        ; 广播出去
}

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk