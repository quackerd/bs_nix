#!/bin/bash

echo "Applying wakeup fix"
sudo cp _perf_mode /etc/systemd/system/perf_mode.service
sudo systemctl enable perf_mode
sudo systemctl start perf_mode

