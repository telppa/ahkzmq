; 收发二进制示例 - 服务端

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.REP)
socket.bind("tcp://*:5555")

loop 10000
{
  buf_arr := socket.recv_binary()                ; recv_binary() 的返回值必须用 parse_buffer_array() 解析
  socket.send_string("2_recv.ico")
}

size := zmq.parse_buffer_array(var_out, buf_arr) ; 将收到的对象 buf_arr 转为变量 var_out

f := FileOpen("2_recv.ico", "w")                 ; 将变量 var_out 存为文件 2_recv.ico
f.RawWrite(var_out, size)
f.Close()

ExitApp

#Include %A_LineFile%\..\..\..\ZeroMQ\ZeroMQ.ahk