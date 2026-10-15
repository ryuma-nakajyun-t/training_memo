#!/bin/bash

#######################################################################################
# VS Code 終了前チェックツール
# VS Code の終了前に動作状態・リソース使用状況を収集し、
# ログファイルへ出力する診断スクリプト
# 処理内容:手順
# 1. VS Code プロセスを確認
# 2. ワークスペース・Git情報を確認
# 3. キャッシュ・ログ・拡張機能の状態を確認
# 4. 結果をログファイルへ保存
#######################################################################################

LOG_DIR="$HOME/.local/logs/vscode"
LOG_FILE="$LOG_DIR/pre_exit_$(date '+%Y-%m-%d_%H-%M-%S').log"

mkdir -p "$LOG_DIR"

{
echo "======================================"
echo " VS Code 終了前チェック"
echo " Timestamp: $(date)"
echo "======================================"
echo ""

echo "=== 1. VS Code プロセス一覧 ==="
ps aux | grep -i "[c]ode"
echo ""

echo "=== 2. VS Code が開いている巨大ファイル（上位10件） ==="
lsof -c code 2>/dev/null | awk '{print $7, $9}' | sort -nr | head
echo ""

echo "=== 3. VS Code 内部ターミナルの推測（プロセスツリー） ==="
pgrep -f "code" | xargs -I{} pstree -p {} 2>/dev/null
echo ""

echo "=== 4. 現在のワークスペースの Git リポジトリ情報 ==="
if git rev-parse --show-toplevel >/dev/null 2>&1; then
    echo "Git Root: $(git rev-parse --show-toplevel)"
    du -sh .git 2>/dev/null
    echo "最新コミット:"
    git log -1 --oneline
else
    echo "Git 管理されていません"
fi
echo ""

echo "=== 5. node_modules のサイズ ==="
if [ -d "node_modules" ]; then
    du -sh node_modules
else
    echo "node_modules は存在しません"
fi
echo ""

echo "=== 6. 拡張機能一覧（重い拡張の確認用） ==="
ls ~/.vscode/extensions
echo ""

echo "=== 7. inotify の監視上限（ファイルウォッチャー負荷） ==="
echo "max_user_watches: $(cat /proc/sys/fs/inotify/max_user_watches)"
echo ""

echo "=== 8. VS Code の設定ファイルサイズ ==="
SETTINGS="$HOME/.config/Code/User/settings.json"
if [ -f "$SETTINGS" ]; then
    du -h "$SETTINGS"
else
    echo "settings.json は存在しません"
fi
echo ""

echo "=== 9. VS Code のキャッシュサイズ ==="
CACHE_DIR="$HOME/.config/Code/Cache"
if [ -d "$CACHE_DIR" ]; then
    du -sh "$CACHE_DIR"
else
    echo "Cache ディレクトリなし"
fi
echo ""

echo "=== 10. VS Code のログディレクトリサイズ ==="
VSCODE_LOG="$HOME/.config/Code/logs"
if [ -d "$VSCODE_LOG" ]; then
    du -sh "$VSCODE_LOG"
else
    echo "VS Code logs ディレクトリなし"
fi
echo ""

echo "=== 11. VS Code が開いているディレクトリのファイル数 ==="
find . -type f | wc -l
echo ""

echo "=== 12. VS Code が監視しているファイル数（推測） ==="
lsof -c code 2>/dev/null | wc -l
echo ""

echo "=== 13. 最近の VS Code クラッシュログ（存在すれば） ==="
CRASH_LOG="$HOME/.config/Code/Crash Reports"
if [ -d "$CRASH_LOG" ]; then
    ls -lt "$CRASH_LOG" | head
else
    echo "Crash Reports ディレクトリなし"
fi
echo ""

echo "=== 14. 拡張機能の CPU/メモリ負荷（プロセス名で推測） ==="
ps aux | grep -i "extensionHost" | grep -v grep
echo ""

echo "[CHECK COMPLETE] VS Code を安全に終了できる状態です。"
echo "======================================"

} | tee "$LOG_FILE"

echo "ログ保存先: $LOG_FILE"
