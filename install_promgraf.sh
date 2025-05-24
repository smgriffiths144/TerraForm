#!/bin/bash
sudo su
useradd -M -U prometheus 
cd /home/ec2-user/
wget https://github.com/prometheus/prometheus/releases/download/v3.4.0/prometheus-3.4.0.linux-amd64.tar.gz
tar -xzvf prometheus-3.4.0.linux-amd64.tar.gz
mv prometheus-3.4.0.linux-amd64 /opt/prometheus
chown prometheus:prometheus -R /opt/Ppometheus 
cd /etc/systemd/system/
cat > prometheus.service <<- "EOF"

[Unit]
Description=Prometheus Server
Documentation=https://prometheus.io/docs/introduction/overview/
After=network-online.target


[Service]
User=prometheus
Group=prometheus
Restart=on-failure
ExecStart=/opt/prometheus/prometheus \
--config.file=/opt/prometheus/prometheus.yml \
--storage.tsdb.path=/opt/prometheus/data \
--storage.tsdb.retention.time=30d 

[Install]
WantedBy=multi-user.target
EOF

cd /opt/prometheus/
cat > prometheus.yml <<- "EOF"
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
EOF

systemctl daemon-reload
systemctl start prometheus.service 
systemctl enable prometheus.service 