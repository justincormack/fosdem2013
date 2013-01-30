local S = require "syscall"

local s = S.socket("inet", "stream, nonblock")
s:setsockopt("socket", "reuseaddr", true)
local sa = S.t.sockaddr_in(8000, "127.0.0.1")
s:bind(sa)
s:listen(128)
local ep = S.epoll_create()
ep:epoll_ctl("add", s, "in")


local nl = require "syscall.nl" 
nl.create_interface{name = "dummy0", type = "dummy"}
local i = nl.interfaces()
i.dummy0:up()
i.dummy0:setmac("46:9d:c9:06:dd:dd")
i.dummy0:address("10.10.10.1/24")
print(i)
i.dummy0:down()
i.dummy0:delete()

