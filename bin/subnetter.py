#!/usr/bin/env python3

import sys
import ipaddress as ip

if __name__ == '__main__':
    addr = ip.IPv4Address(sys.argv[1])

    maskarg = sys.argv[2]

    mask = 0

    if maskarg[0] == '/':
        for i in range(32 - int(maskarg[1:])):
            mask <<= 1
            mask |= 1
        mask = ip.IPv4Address(0xFFFFFFFF ^ mask)
    else:
        mask = ip.IPv4Address(maskarg)

    bit_sr = int(sys.argv[3])
    bit_host = int(sys.argv[4])

    sr = 2 ** bit_sr
    host = 2 ** bit_host

    u_sr = sr - 2
    u_host = host - 2

    print(f"IP: {addr}\nMask: {mask}\n"
            f"SR: {sr} ({bit_sr} bit) {u_sr} usable\n"
            f"Host: {host} ({bit_host} bit) {u_host} usable",
            file=sys.stderr)

    for i in range(sr):
        if i < 15 or i == sr - 1:
            print( addr,
                   addr + 1,
                   addr + host - 2,
                   addr + host - 1, sep=",")
        addr += host
