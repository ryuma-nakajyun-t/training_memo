# MySQLをセットアップするPlaybook
playbook.yml
```yaml
---
# MySQLをセットアップするPlaybook
- name: MySQL Setup

  # inventoryのmysqlグループを対象に実行
  hosts: mysql

  # sudo権限で実行
  become: true

  # 変数ファイルを読み込む
  vars_files:
    - group_vars/all.yml

  tasks:

    # MySQL ServerとPyMySQLをインストール
    - name: Install MySQL Server
      apt:
        name:
          - mysql-server      # MySQL本体
          - python3-pymysql   # AnsibleからMySQLを操作するためのライブラリ
        state: present        # インストール済み状態にする
        update_cache: true    # apt update実行

    # MySQLサービスを起動し、自動起動を有効化
    - name: Start MySQL Service
      service:
        name: mysql
        state: started        # 起動状態にする
        enabled: true         # OS起動時に自動起動

    # データベース作成
    - name: Create Database
      community.mysql.mysql_db:
        name: "{{ mysql_db }}" # 例: sampledb
        state: present         # 存在しなければ作成

    # MySQLユーザー作成と権限付与
    - name: Create User
      community.mysql.mysql_user:
        name: "{{ mysql_user }}"         # 例: spring
        password: "{{ mysql_password }}" # ユーザーのパスワード

        # sampledb.* に ALL権限を付与
        priv: "{{ mysql_db }}.*:ALL"

        # 接続元ホスト
        # % は全ホスト許可
        host: "%"

        # ユーザーが存在する状態にする
        state: present
```

このPlaybookを一言でいうと
```text
UbuntuにMySQLをインストール
        ↓
MySQLを起動
        ↓
sampledbを作成
        ↓
springユーザーを作成
        ↓
sampledbへの権限を付与
```
を自動化しています。

コメントは「なぜその設定が必要なのか」が分かるように付けること。  
例えば host: "%"  の箇所に「全ホスト許可のため検証環境向け」などを書いておくと、  
設定の意図まで伝わります。  


# このPlaybookを実行する方法
この Playbook を実行する流れは次のとおりです。  

### 1. ディレクトリ構成を用意
```text
ansible-mysql-setup/
├── inventory
├── playbook.yml
└── group_vars/
    └── all.yml
```

### 2. inventory作成
```text
[mysql]
192.168.1.10
```
ローカル環境で試すなら
```text
[mysql]
localhost ansible_connection=local
```
でも可能です。

### 3. 変数ファイル作成

group_vars/all.yml
```yaml
mysql_db: sampledb
mysql_user: spring
mysql_password: password
```

### 4. Collectionをインストール
community.mysql.mysql_db や community.mysql.mysql_user
を使用するため、事前にCollectionを導入します。
```bash
ansible-galaxy collection install community.mysql
```

- 確認  
ansible-galaxy collection list

### 5. Playbook実行
ansible-playbook -i inventory playbook.yml

### 6. 実行結果確認
成功すると
```text
PLAY RECAP
192.168.1.10 : ok=4 changed=4 failed=0
```
のように表示されます。

### 7. MySQL確認
サーバへログインし、
```bash
systemctl status mysql
```

DB確認
```bash
sudo mysql
```
SHOW DATABASES;


- 結果例
sampledb


ユーザー確認
```sql
SELECT user, host
FROM mysql.user;
```

- 結果例
spring    %

冪等性の確認
Ansibleの重要な特徴です。
同じPlaybookを再実行しても、
```bash
ansible-playbook -i inventory playbook.yml
```

変更がなければ
```text
changed=0
```
になります。

つまり
```text
1回目
→ MySQLインストール

2回目
→ 何もしない
```
という安全な動作になります。

これが 「Ansibleの冪等性(idempotency)」 の代表例です。


# SSH接続設定も含めて・安全なパスワード管理に変更して
実務を意識するなら、以下のように改善すると良いです。
- SSH鍵認証を利用
- DBパスワードを平文で書かない
- Ansible Vaultで暗号化
- 接続元を % ではなく限定
- root実行を最小限にする

playbook.yml
```yaml
---
# MySQLを自動構築するPlaybook
- name: MySQL Setup
  hosts: mysql
  become: true

  # Vaultで暗号化された変数を読み込む
  vars_files:
    - group_vars/all.yml
    - group_vars/vault.yml

  tasks:

    # パッケージ情報更新とMySQL導入
    - name: Install MySQL Server
      apt:
        name:
          - mysql-server
          - python3-pymysql
        state: present
        update_cache: true

    # MySQLサービス起動
    - name: Enable and Start MySQL Service
      service:
        name: mysql
        state: started
        enabled: true

    # データベース作成
    - name: Create Database
      community.mysql.mysql_db:
        name: "{{ mysql_db }}"
        state: present

    # アプリケーションユーザー作成
    - name: Create Application User
      community.mysql.mysql_user:
        name: "{{ mysql_user }}"
        password: "{{ vault_mysql_password }}"

        # 接続元を限定
        host: "{{ app_server_host }}"

        priv: "{{ mysql_db }}.*:ALL"

        state: present
```

inventory
```text
[mysql]
192.168.1.10

[mysql:vars]
ansible_user=ansible
ansible_ssh_private_key_file=~/.ssh/id_rsa
```

パスワード認証ではなく、
```text
SSH公開鍵認証
```
で接続します。

group_vars/all.yml
mysql_db: sampledb
mysql_user: spring

# 接続元制限
app_server_host: 192.168.1.20

group_vars/vault.yml
vault_mysql_password: SuperSecurePassword123!

ただしこのファイルは平文保存しません。

Vault暗号化
```text
ansible-vault encrypt group_vars/vault.yml
```

閲覧
```text
ansible-vault view group_vars/vault.yml
```

編集
```text
ansible-vault edit group_vars/vault.yml
```

Playbook実行
```bash
ansible-playbook \
-i inventory \
playbook.yml \
--ask-vault-pass
```
または
```bash
ansible-playbook \
-i inventory \
playbook.yml \
--vault-password-file ~/.vault_pass.txt
```

この構成だと単なる  
MySQLインストール自動化ではなく、  
- SSH鍵認証
- Ansible Vault
- DB自動構築
- 権限制御
- 冪等性  
まで考慮しているため、

「Ansibleを使って安全にMySQLサーバを構築できる」
これは初級の「インストール手順書」より一段上の内容です。
