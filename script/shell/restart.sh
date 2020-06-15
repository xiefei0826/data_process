#!/usr/bin/env bash
sudo systemctl restart ntp;
sudo ambari-server restart;
sudo ambari-agent restart;
sudo chown -R xf /var/run/ambari-server/