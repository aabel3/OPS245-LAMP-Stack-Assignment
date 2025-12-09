#!/bin/bash

# Allow HTTP traffic (port 80)
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Allow SSH traffic (port 22)
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow established connections
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow DNS for apt
sudo iptables -A INPUT -p udp --dport 53 -j ACCEPT

# Set default policy to DROP
sudo iptables -P INPUT DROP