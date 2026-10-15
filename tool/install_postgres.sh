#!/usr/bin/env bash

#######################################################################################
# PostgreSQL インストールスクリプト
# PostgreSQL のインストールおよび初期起動を行う
# 処理内容:手順
# 1. パッケージリストを更新
# 2. PostgreSQL をインストール
# 3. PostgreSQL サービスを有効化・起動
# 4. サービス状態を確認
#######################################################################################

set -euo pipefail

echo "=== Update package list ==="
sudo apt update

echo "=== Install PostgreSQL ==="
sudo apt install -y postgresql postgresql-contrib

echo "=== Enable & Start PostgreSQL service ==="
sudo systemctl enable postgresql
sudo systemctl start postgresql

echo "=== Show PostgreSQL status ==="
sudo systemctl status postgresql --no-pager

echo "=== Setup complete ==="
echo "You can now switch to postgres user with:"
echo "  sudo -i -u postgres"
echo "And enter psql with:"
echo " psql"
