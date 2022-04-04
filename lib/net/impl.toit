// Copyright (C) 2021 Toitware ApS. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the lib/LICENSE file.

import monitor

import .net as net
import .tcp as tcp
import .udp as udp

import .modules.dns as dns
import .modules.tcp
import .modules.udp

import system.api.network show NetworkServiceClient NetworkResource

service_value_/NetworkServiceClient? := null
service_mutex_/monitor.Mutex ::= monitor.Mutex

service_ -> NetworkServiceClient?:
  return service_value_ or service_mutex_.do:
    service_value_ = (NetworkServiceClient --no-open).open

open -> net.Interface:
  service := service_
  if not service: throw "Network unavailable"
  return SystemInterface_ service service.connect

// TODO(kasper): Find a way to listen for network closing.
class SystemInterface_ extends NetworkResource implements net.Interface:
  constructor service/NetworkServiceClient handle/int:
    super service handle

  resolve host/string -> List:
    if not handle_: throw "Network closed"
    return [dns.dns_lookup host]

  udp_open --port/int?=null -> udp.Socket:
    if not handle_: throw "Network closed"
    return Socket "0.0.0.0" (port ? port : 0)

  tcp_connect host/string port/int -> tcp.Socket:
    ips := resolve host
    return tcp_connect
        net.SocketAddress ips[0] port

  tcp_connect address/net.SocketAddress -> tcp.Socket:
    if not handle_: throw "Network closed"
    result := TcpSocket
    result.connect address.ip.stringify address.port
    return result

  tcp_listen port/int -> tcp.ServerSocket:
    if not handle_: throw "Network closed"
    result := TcpServerSocket
    result.listen "0.0.0.0" port
    return result

  address -> net.IpAddress:
    if not handle_: throw "Network closed"
    return super

/*
RPC_NETWORK_RESOLVE ::= 502

RPC_NETWORK_UDP_OPEN ::= 504

RPC_NETWORK_UDP_CONNECT ::= 511
RPC_NETWORK_UDP_RECEIVE ::= 512
RPC_NETWORK_UDP_SEND ::= 513
RPC_NETWORK_UDP_BROADCAST ::= 514
RPC_NETWORK_UDP_SET_BROADCAST ::= 515
RPC_NETWORK_UDP_WRITE ::= 516
RPC_NETWORK_UDP_READ ::= 517
RPC_NETWORK_UDP_LOCAL_ADDRESS ::= 518
RPC_NETWORK_UDP_CLOSE ::= 519
RPC_NETWORK_UDP_MTU ::= 520

RPC_NETWORK_TCP_CONNECT ::= 505
RPC_NETWORK_TCP_LISTEN ::= 506

RPC_NETWORK_TCP_PEER_ADDRESS ::= 507
RPC_NETWORK_TCP_SET_NO_DELAY ::= 508
RPC_NETWORK_TCP_CLOSE_WRITE ::= 509
RPC_NETWORK_TCP_ACCEPT ::= 510
RPC_NETWORK_TCP_WRITE ::= 516
RPC_NETWORK_TCP_READ ::= 517
RPC_NETWORK_TCP_LOCAL_ADDRESS ::= 518
RPC_NETWORK_TCP_CLOSE ::= 519
RPC_NETWORK_TCP_MTU ::= 520

RPC_MAX_DATA_SIZE_ ::= 2048

class InterfaceImpl_ extends Interface:
  resolve host/string -> List:
    addresses := rpc.invoke RPC_NETWORK_RESOLVE [handle_, host]
    return addresses.map: IpAddress it

  address -> IpAddress:
    address := rpc.invoke RPC_NETWORK_ADDRESS [handle_]
    return IpAddress.deserialize address

  udp_open -> udp.Socket: return udp_open --port=null
  udp_open --port/int? -> udp.Socket:
    handle := rpc.invoke RPC_NETWORK_UDP_OPEN [handle_, port]
    return UdpSocketImpl_ handle

  tcp_connect address/SocketAddress -> tcp.Socket:
    handle := rpc.invoke RPC_NETWORK_TCP_CONNECT [handle_, address.to_byte_array]
    return TcpSocketImpl_ handle

  tcp_listen port/int -> tcp.ServerSocket:
    handle := rpc.invoke RPC_NETWORK_TCP_LISTEN [handle_, port]
    return TcpServerSocketImpl_ handle

class UdpSocketImpl_ extends rpc.CloseableProxy implements udp.Socket:
  constructor handle:
    super handle

  close_rpc_selector_ -> int: return RPC_NETWORK_SOCKET_CLOSE

  local_address -> SocketAddress:
    return SocketAddress.deserialize
      rpc.invoke RPC_NETWORK_SOCKET_LOCAL_ADDRESS [handle_]

  receive -> udp.Datagram:
    return udp.Datagram.deserialize
      rpc.invoke RPC_NETWORK_UDP_RECEIVE [handle_]

  send datagram/udp.Datagram -> none:
    rpc.invoke RPC_NETWORK_UDP_SEND [handle_, datagram.to_byte_array]

  connect address/SocketAddress -> none:
    rpc.invoke RPC_NETWORK_UDP_CONNECT [handle_, address.to_byte_array]

  read -> ByteArray?:
    return rpc.invoke RPC_NETWORK_SOCKET_READ [handle_]

  write data from/int=0 to/int=data.size -> int:
    to = min to (from + RPC_MAX_DATA_SIZE_)
    return rpc.invoke RPC_NETWORK_SOCKET_WRITE [handle_, data[from..to]]

  mtu -> int:
    return rpc.invoke RPC_NETWORK_SOCKET_MTU [handle_]

  broadcast -> bool:
    return rpc.invoke RPC_NETWORK_UDP_BROADCAST [handle_]

  broadcast= value/bool:
    rpc.invoke RPC_NETWORK_UDP_SET_BROADCAST [handle_, value]

class TcpSocketImpl_ extends rpc.CloseableProxy implements tcp.Socket:

  constructor handle:
    super handle

  close_rpc_selector_ -> int: return RPC_NETWORK_SOCKET_CLOSE

  local_address -> SocketAddress:
    return SocketAddress.deserialize
      rpc.invoke RPC_NETWORK_SOCKET_LOCAL_ADDRESS [handle_]

  peer_address -> SocketAddress:
    return SocketAddress.deserialize
      rpc.invoke RPC_NETWORK_TCP_PEER_ADDRESS [handle_]

  set_no_delay enabled/bool:
    return rpc.invoke RPC_NETWORK_TCP_SET_NO_DELAY [handle_, enabled]

  read -> ByteArray?:
    return rpc.invoke RPC_NETWORK_SOCKET_READ [handle_]

  write data from/int=0 to/int=data.size -> int:
    to = min to (from + RPC_MAX_DATA_SIZE_)
    return rpc.invoke RPC_NETWORK_SOCKET_WRITE [handle_, data[from..to]]

  close_write:
    return rpc.invoke RPC_NETWORK_TCP_CLOSE_WRITE [handle_]

  mtu:
    return rpc.invoke RPC_NETWORK_SOCKET_MTU [handle_]

class TcpServerSocketImpl_ implements tcp.ServerSocket:
  handle_ ::= ?

  constructor .handle_:

  local_address -> SocketAddress:
    return SocketAddress.deserialize
      rpc.invoke RPC_NETWORK_SOCKET_LOCAL_ADDRESS [handle_]

  close:
    return rpc.invoke RPC_NETWORK_SOCKET_CLOSE [handle_]

  accept -> tcp.Socket?:
    handle := rpc.invoke RPC_NETWORK_TCP_ACCEPT [handle_]
    if not handle: return null
    return TcpSocketImpl_ handle


*/