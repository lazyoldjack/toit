// Copyright (C) 2022 Toitware ApS. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the lib/LICENSE file.

import net
import net.udp

import system.services show ServiceClient ServiceResourceProxy

interface NetworkService:
  static NAME  /string ::= "system/network"
  static MAJOR /int    ::= 0
  static MINOR /int    ::= 1

  static CONNECT_INDEX /int ::= 0
  connect -> int

  static ADDRESS_INDEX /int ::= 1
  address handle/int -> ByteArray

  // static MTU_INDEX ::= 2

  static UDP_OPEN_INDEX /int ::= 3
  udp_open handle/int -> int

  static UDP_CONNECT_INDEX /int ::= 4
  udp_connect handle/int -> none

  static UDP_RECEIVE_INDEX /int ::= 5
  udp_receive handle/int -> udp.Datagram

  static UDP_SEND_INDEX /int ::= 6
  udp_send handle/int datagram/udp.Datagram -> none

  //static UDP_BROADCAST_INDEX /int ::= 7

  //static UDP_SET_BROADCAST_INDEX /int ::= 8

  static UDP_WRITE_INDEX /int ::= 9
  udp_write handle/int data/ByteArray -> none

  static UDP_READ_INDEX /int ::= 10
  udp_read handle/int -> ByteArray?

  static UDP_LOCAL_ADDRESS /int ::= 11
  udp_local_address -> net.SocketAddress

  static TCP_CONNECT /int ::= 3
  tcp_open handle/int -> int

  static TCP_LISTEN /int ::= 4
  tcp_listen handle/int -> int

class NetworkServiceClient extends ServiceClient implements NetworkService:
  constructor --open/bool=true:
    super --open=open

  open -> NetworkServiceClient?:
    return (open_ NetworkService.NAME NetworkService.MAJOR NetworkService.MINOR) and this

  connect -> int:
    return invoke_ NetworkService.CONNECT_INDEX null

  address handle/int -> ByteArray:
    return invoke_ NetworkService.ADDRESS_INDEX handle

  udp_connect address/SocketAddress -> int:
    return invoke_ NetworkService.UDP_CONNECT_INDEX address

class NetworkResource extends ServiceResourceProxy:
  constructor client/NetworkServiceClient handle/int:
    super client handle

  address -> net.IpAddress:
    return net.IpAddress
        (client_ as NetworkServiceClient).address handle_

  udp_connect

class UdpSocketResource extends ServiceResourceProxy:
  // ...

class TcpSocketResource extends ServiceResourceProxy:
  //...
