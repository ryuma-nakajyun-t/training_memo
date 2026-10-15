# コマンド一覧 ＋ 説明 ＋ 動作しない可能性
## 項目一覧
1. 権限・ユーザー管理
2. SSH / ロケール / システム設定
3. パッケージ管理 / 開発環境
4. ファイル操作 / ディレクトリ操作
5. ネットワーク / ダウンロード
6. SSL / 証明書
7. Go 言語関連
8. C言語
9. Git / SSH

## 1. 権限・ユーザー管理
### コマンド一覧
```bash
su
sudo passwd root
exit
passwd
sudo chown -R $USER:$USER ~
sudo chown -R $USER:$USER ~/.vscode-server ~/.vscode-remote
sudo kill -9 <PID>
```
### 説明
- su：ユーザー切り替え
- sudo passwd root：root のパスワード設定
- passwd：現在のユーザーのパスワード変更
- chown：所有者変更
- kill -9：プロセス強制終了
### 動作しない可能性
- PID を実際の番号に置き換えないと失敗
- root のパスワード設定は OS によって禁止されている場合あり

## 2. SSH / ロケール / システム設定
### コマンド一覧
```bash
cat /etc/ssh/sshd_config
vi /etc/ssh/sshd_config
sudo nano /etc/ssh/sshd_config
cat ~/.ssh/config
locale
lacale
apt update
locale-gen ja_JP.UTF-8
ip a
sudo dpkg-reconfigure dash
```
### 説明
- SSH 設定確認・編集
- ロケール設定
- ネットワーク確認
- /bin/sh の切り替え（dash ↔ bash）
### 動作しない可能性
- lacale → typo（locale の誤字）
- locale-gen は OS によって非推奨
- dpkg-reconfigure dash は Debian 系以外では動かない

## 3. パッケージ管理 / 開発環境
### コマンド一覧
```bash
sudo apt install mkcert
mkcert 192.168.3.250
mkcert -install
sudo apt update
sudo apt install -y build-essential
gcc --version
sudo apt remove code
sudo apt purge code
sudo snap remove code
sudo add-apt-repository ppa:git-core/ppa
sudo apt install git
```
### 説明
- mkcert のインストール
- build-essential（gcc など）
- VSCode の削除
- Git のインストール
### 動作しない可能性
- snap remove code は snap 版 VSCode が入っていないと失敗
- add-apt-repository は software-properties-common が必要な場合あり

## 4. ファイル操作 / ディレクトリ操作
### コマンド一覧
```bash
ls /homewa
ls -l ~/.vscode-server
ls -a ~ | grep vscode
df -h ~
ls -l ~/.vscode-server/bin
ls ~/.vscode-server/cli/servers
ls ~/.vscode-server/data/logs
ls ~/.vscode-server/data/logs/20260511T200103/
ls -l ~/.vscode-server/cli/servers/.../server/bin/node
ls -l /bin/sh
rm -rf ~/.vscode-server
rm -rf ~/.vscode-remote
rm -rf ~/.cache/Code
rm -rf ~/.config/Code/CachedData
rm -rf ~/.vscode-server/data/logs/*
rm -rf ~/.vscode-server/extensions/*
rm -rf ~/.vscode-server/cli/*
cd home
cd ryuma/
ls -ld .
ls -l
```
### 説明
- VSCode Server のログ・キャッシュ削除
- ディレクトリ移動
- ファイル一覧確認
### 動作しない可能性
- ls /homewa → 存在しないパス
- cd home → 相対パスとして存在しない
- cd ryuma/ → カレントディレクトリによっては存在しない
- VSCode Server が壊れていると多くの ls ~/.vscode-server/... が失敗

## 5. ネットワーク / ダウンロード
### コマンド一覧
```bash
wget https://amano-tec.com/data/asti-datr0711wc.zip
unzip asti-datr0711wc.zip
rm -f asti-datr0711wc.zip
rm asti-datr0711wc.zip
file asti-datr0711wc.zip
curl -O https://amano-tec.com/data/asti-datr0711wc.zip
```
### 説明
- ZIP ダウンロード
- 解凍
- 削除
- ファイルタイプ確認
### 動作しない可能性
- unzip がインストールされていないと失敗
- URL が死んでいると失敗

## 6. SSL / 証明書
### コマンド一覧
```bash
openssl req -x509 -newkey rsa:2048 -keyout server.key -out server.crt -days 365 -nodes -subj "/CN=192.168.3.250" -addext "subjectAltName = IP:192.168.3.250"
mkcert 192.168.3.250
mkcert -install
```
### 説明
- OpenSSL で自己署名証明書作成
- mkcert でローカル証明書作成
### 動作しない可能性
- -addext は古い OpenSSL では使えない
- mkcert は root CA のインストールに失敗することがある

## 7. Go 言語関連
### コマンド一覧
```bash
go run main.go
go version
export PATH="$HOME/.local/go/bin:$PATH"
source ~/.bashrc
ls $HOME/.local/go/bin
echo 'export PATH="$HOME/.local/go/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="$HOME/.local/go/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
./main.go
chmod 755 main.go
ls $HOME/.local/go/bin/go
ls $HOME/.local/go/
ls $HOME/.local
tar -C $HOME/.local -xzf /home/ryuma/go1.22.0.linux-amd64.tar.gz
go versin
go mod init hello-cli
tree
go run helllo-cli.go
go run helllo-cli.go ryuma
go run r0711world_utf8.tsv
```
### 説明
- Go の PATH 設定
- Go プログラム実行
- Go の展開
- Go モジュール初期化
### 動作しない可能性（重要）
- ./main.go → Go ファイルは直接実行できない
- go versin → typo
- helllo-cli.go → typo
- go run r0711world_utf8.tsv → .tsv は Go ソースではない
- PATH が正しく設定されていないと go が動かない

## 8. C言語
### コマンド一覧
```bash
vi create_project.c
chmod 755 create_project.c
gcc create_project.c -o create_project
./create_projecth
```
### 説明
- C ソース編集
- コンパイル
- 実行
### 動作しない可能性
- ./create_projecth → ファイル名が誤り

## 9. Git / SSH
### コマンド一覧
```bash
git --version
git init
git add .
git commit -m "update myproject"
git push origin main
git remote -v
ssh-keygen -t ed25519 -C "ryuma-nakajyun@users.noreply.github.com"
cat ~/.ssh/id_ed25519.pub
git remote set-url origin git@github.com:ryuma-nakajyun/c.git
ssh -T git
```
### 説明
- Git 初期化
- GitHub SSH 設定
- リモート設定
### 動作しない可能性
- ssh -T git → 正しくは ssh -T git@github.com
- SSH 鍵のパーミッションが正しくないと GitHub に接続できない

# まとめ：動作しない可能性が高いコマンド（重要）
## 確実に動かない
```
lacale
ls /homewa
go versin
helllo-cli.go
./main.go
go run r0711world_utf8.tsv
./create_projecth
ssh -T git
```

## 環境によって失敗する
```
dpkg-reconfigure dash
mkcert -install
openssl -addext
VSCode Server 関連の ls
snap remove code
```
