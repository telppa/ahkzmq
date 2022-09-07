; 收发多帧二进制示例 - 服务端

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.REP)
socket.bind("tcp://*:5555")

loop 10000
{
  buf_arr := socket.recv_binary()                   ; recv_binary() 的返回值必须用 parse_buffer_array() 解析
  socket.send_string("4_recv.ico")
}

zmq.parse_buffer_array(str_out, buf_arr, 1)         ; 将第一帧存为变量 str_out
size := zmq.parse_buffer_array(var_out, buf_arr, 2) ; 将第二帧存为变量 var_out

f := FileOpen("4_recv.ico", "w")                    ; 将变量 var_out 存为文件 4_recv.ico
f.RawWrite(var_out, size)
f.Close()

MsgBox % StrGet(&str_out)                           ; 显示第一帧的内容

ExitApp

#Include %A_LineFile%\..\..\..\ZeroMQ\ZeroMQ.ahk