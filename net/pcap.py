## sudo python required!

import py_pcapplusplus as pcpp

class Node: pass

class Send(Node):
    name = 'veths'
    mac = "00:11:22:33:44:55"
    ip = "1.2.3.4"

class Recv(Node):
    name = 'vethr'
    mac = "66:77:88:99:aa:bb"
    ip = "5.6.7.8"

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
