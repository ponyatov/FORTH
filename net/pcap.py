## sudo python required!

import py_pcapplusplus as pcpp

class Node: pass

class Send(Node):
    name = 'veths'
    mac = "e2:9b:e8:7a:a2:97"
    ip = "111.111.111.111"
    port = 5432

class Recv(Node):
    name = 'vethr'
    mac = "d6:4e:45:79:3c:e6"
    ip = "111.111.111.222"
    port = 12345

# sender
veths = pcpp.RawSocket(Send.name)
# receiver
vethr = pcpp.RawSocket(Recv.name)

# new packet
packet = pcpp.Packet()

# add layers
eth = pcpp.EthLayer(src_mac_addr=Send.mac,
                    dst_mac_addr=Recv.mac)
ip = pcpp.IPv4Layer(src_addr=Send.ip,
                    dst_addr=Recv.ip)
udp = pcpp.UdpLayer(src_port=Send.port,
                    dst_port=Recv.port)

packet / eth / ip / udp

# sudo nc -u -l 111.111.111.222 -p 12345
