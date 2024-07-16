#!/bin/bash

apt update
apt upgrade

apt install qbittorrent-nox

adduser --system --group qbittorrent-nox
adduser qbittorrent-nox qbittorrent-nox

echo "[Unit]
Description=qBittorrent Command Line Client
After=network.target

[Service]
Type=forking
User=qbittorrent-nox
Group=qbittorrent-nox
UMask=007
ExecStart=/usr/bin/qbittorrent-nox -d --webui-port=8080
Restart=on-failure

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/qbittorrent-nox.service

systemctl daemon-reload
systemctl start qbittorrent-nox
systemctl enable qbittorrent-nox
