#!/bin/bash

echo "Applying wakeup fix"
sudo cp _wakeup_fix /etc/systemd/system/wakeup-fix.service
sudo systemctl enable wakeup-fix
sudo systemctl start wakeup-fix

