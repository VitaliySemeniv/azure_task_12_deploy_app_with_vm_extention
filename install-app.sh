#!/usr/bin/env bash
set -euxo pipefail
export DEBIAN_FRONTEND=noninteractive

# 1) Оновлення системи та встановлення необхідних пакетів
apt-get update -yq
apt-get install -yq git python3-pip

# 2) Створення директорії для апки
mkdir -p /app

# 3) Клонування твого репозиторію
TMP_DIR=/tmp/todoapp
rm -rf "$TMP_DIR"
git clone --depth 1 https://github.com/VitaliySemeniv/azure_task_12_deploy_app_with_vm_extention.git "$TMP_DIR"

# 4) Копіювання файлів апки в /app
cp -r "$TMP_DIR/app/"* /app

# 5) Встановлення залежностей Python
pip3 install --break-system-packages -r /app/requirements.txt

# 6) Копіювання systemd-сервісу і запуск
cp /app/todoapp.service /etc/systemd/system/todoapp.service
systemctl daemon-reload
systemctl enable todoapp
systemctl start todoapp
