#NoEnv
SetBatchLines -1

OnMessage(0x5555, "fn")

zmq := new ZeroMQ
context := zmq.context()
receiver := context.socket(zmq.PULL)
receiver.connect("tcp://localhost:5557")

; 确保连接上再开始计时，这样无论先启动 pull.ahk 还是 push.ahk 计时都是一样的
receiver.recv_string()

loop 1000000
{
  VarSetCapacity(var, 10)
  receiver.recv(&var, 10) ; 1215ms
  ; msg := receiver.recv_string() ; 1714ms
}

return

; PostMessage 消息只会启动一次 fn() ， SendMessage 则正常
fn(wParam, lParam)
{
  return
}

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk