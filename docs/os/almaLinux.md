# AlmaLinux
AlmaLinux（アルマリナックス） は、Red Hat Enterprise Linux（RHEL）と高い互換性を持つ、無料のLinuxディストリビューションです。  
もともとは CentOS 8 のサポート終了問題 を受けて、CentOSの後継候補として誕生しました。  

特徴
無料
RHELと同等レベルの環境を無償で利用可能
RHEL互換
RHEL向けに作られたソフトウェアや手順書をほぼそのまま利用できる
長期サポート
1つのメジャーバージョンに対して長期間のセキュリティ更新が提供される

コミュニティ主導  
特定企業だけでなく非営利組織 AlmaLinux OS Foundation が運営  
RHEL系の関係
RHEL
 ├─ AlmaLinux
 ├─ Rocky Linux
 └─ Oracle Linux

よく使われる用途

Webサーバー

Apache
Nginx

DBサーバー

PostgreSQL
MySQL
MariaDB

アプリケーションサーバー

Java (Spring Boot)
Tomcat

クラウド環境

AWS
Azure
OCI
Rocky Linuxとの違い

CentOS終了後の移行先としてよく比較されます。

項目	AlmaLinux	Rocky Linux開発元	AlmaLinux Foundation	Rocky Enterprise Software Foundation
RHEL互換性	高い	高い
利用者数	多い	多い
導入難易度	ほぼ同じ	ほぼ同じ

実務目線では 「どちらを選んでも大きな差はない」 ケースが多いです。

あなたの経歴との関係

Ansible、DB、Linux運用経験があるなら、AlmaLinuxはかなり相性が良いです。

例えば：

dnf install nginx
systemctl enable nginx
systemctl start nginx


のように、RHEL系で一般的な運用手順がそのまま使えます。

案件でも

RHEL
AlmaLinux
Rocky Linux
のいずれかに触れる機会は多く、1つ慣れてしまえば他も比較的扱いやすいです。
特に運用保守や基盤系の案件では現在もよく見かけます。  


# AlmaLinuxのインストール方法
AlmaLinux のインストール方法はいくつかありますが、個人学習なら VirtualBoxにインストール するのがおすすめです。

1. ISOイメージをダウンロード

公式サイトからISOを取得します。

https://almalinux.org/

一般的には以下を選びます。

AlmaLinux 10 または AlmaLinux 9
x86_64
DVD ISO

※ 検証用途なら AlmaLinux 9 が無難です。

2. VirtualBoxをインストール

Windows 11の場合

VirtualBox
VirtualBox Extension Pack（必要なら）

をインストールします。

3. 仮想マシン作成

VirtualBoxで

新規

設定例

名前: AlmaLinux9
タイプ: Linux
バージョン: Red Hat (64-bit)

メモリ:
4096MB

CPU:
2コア

ディスク:
50GB以上
VDI
可変サイズ

4. ISOをマウント

仮想マシン設定

ストレージ
↓
光学ドライブ
↓
ISO選択


ダウンロードした

AlmaLinux-9.x-x86_64-dvd.iso


を指定します。

5. インストーラ起動

仮想マシンを起動すると

Install AlmaLinux


を選択します。

6. インストール設定
言語
日本語


または

English

インストール先

通常は

自動構成


で問題ありません。

ネットワーク

右上のスイッチを

OFF → ON


に変更します。

rootパスワード

例

root


ユーザー作成も行います。

ユーザー名
takuma

管理者権限
ON

7. インストール開始
インストール開始


をクリック。

数分待つと完了します。

8. 再起動
Reboot System


をクリック。

再起動後はISOを取り外します。

9. ログイン確認
cat /etc/os-release


実行。

例

NAME="AlmaLinux"
VERSION="9.6 (Sage Margay)"


のように表示されれば成功です。

10. 初期設定

パッケージ更新

sudo dnf update -y


ホスト名変更

sudo hostnamectl set-hostname almalinux-dev


確認

hostnamectl

あなた向けの学習順序

隆磨さんは Ansible や Linux 運用経験があるので、インストール後は
- ユーザー管理
- systemctl
- firewalld
- nginx
- MariaDB
- SSH鍵認証
- Ansibleで自動構築
の順に触ると実務に近い学習になります。

特に AlmaLinux は RHEL 系なので、
```bash
dnf
systemctl
firewalld
SELinux
```

を理解すると、RHEL・Rocky Linux・Oracle Linuxにも応用できます。

