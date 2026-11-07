# ubuntsuでmysqlの環境構築
Ubuntu で MySQL を構築するなら、基本は以下の流れです。

### 0. mysqlのインストール確認
```bash
mysql --version
```

### 1. パッケージ情報を更新
```bash
sudo apt update
```

### 2. MySQL をインストール
```bash
sudo apt install mysql-server
```
インストール後、サービスが自動起動します。

- インストールに失敗した場合
-y オプションだとインストール失敗したので、
手順「mysql-server パッケージの状態を確認」を実施。
~~sudo apt install mysql-server -y~~  

### 2.1. MySQL がインストール確認
```bash
mysql --version
```
```text
mysql  Ver 8.0.46-0ubuntu0.24.04.4 for Linux on x86_64 ((Ubuntu))
```
これが出力された場合は、インストール成功 

### 3. 起動確認
```bash
sudo systemctl status mysql
```
または
```bash
sudo systemctl is-active mysql
```

- 結果  
active  
なら正常です。  

### 4. 初期設定
```bash
sudo mysql_secure_installation
```

以下を設定できます。
- rootパスワード
- 匿名ユーザー削除
- テストDB削除
- rootのリモートログイン制限
学習目的なら基本的に Y で進めて構いません。

### 5. MySQLへ接続
Ubuntuでは root をOS認証でログインできることがあります。
```bash
sudo mysql
```

接続成功すると
```text
mysql>
```
が表示されます。

### 6. DB作成
```sql
CREATE DATABASE sampledb;
```

- 確認
```sql
SHOW DATABASES;
```

### 7. ユーザー作成
```sql
CREATE USER 'spring'@'localhost'
IDENTIFIED BY 'password';
```

- 権限付与
```sql
GRANT ALL PRIVILEGES
ON sampledb.*
TO 'spring'@'localhost';
```

- 反映
```sql
FLUSH PRIVILEGES;
```

- 確認
```sql
SELECT user, host
FROM mysql.user;
```

### 8. Spring Boot接続設定
application.properties
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/sampledb
spring.datasource.username=spring
spring.datasource.password=password

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

### Maven依存関係
pom.xml
```xml
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
</dependency>
```

### よく使う確認コマンド  
- バージョン確認
```bash
mysql --version
```
```text
mysql  Ver 8.0.46-0ubuntu0.24.04.4 for Linux on x86_64 ((Ubuntu))
```

- 起動
```bash
sudo systemctl start mysql
```
```text
● mysql.service - MySQL Community Server
     Loaded: loaded (/usr/lib/systemd/system/mysql.service>
     Active: active (running) since Tue 2026-10-27 02:45:4>
    Process: 56544 ExecStartPre=/usr/share/mysql/mysql-sys>
   Main PID: 56563 (mysqld)
     Status: "Server is operational"
      Tasks: 37 (limit: 7966)
     Memory: 363.7M (peak: 378.6M)
        CPU: 11.661s
     CGroup: /system.slice/mysql.service
             └─56563 /usr/sbin/mysqld

10月 27 02:45:41 vm01 systemd[1]: Starting mysql.service ->
10月 27 02:45:43 vm01 systemd[1]: Started mysql.service - >
```

- 停止
```bash
sudo systemctl stop mysql
```
```text
○ mysql.service - MySQL Community Server
     Loaded: loaded (/usr/lib/systemd/system/mysql.service>
     Active: inactive (dead) since Tue 2026-10-27 03:50:00>
   Duration: 1h 4min 16.974s
    Process: 56544 ExecStartPre=/usr/share/mysql/mysql-sys>
    Process: 56563 ExecStart=/usr/sbin/mysqld (code=exited>
   Main PID: 56563 (code=exited, status=0/SUCCESS)
     Status: "Server shutdown complete"
        CPU: 46.912s

10月 27 02:45:41 vm01 systemd[1]: Starting mysql.service ->
10月 27 02:45:43 vm01 systemd[1]: Started mysql.service - >
10月 27 03:50:00 vm01 systemd[1]: Stopping mysql.service ->
10月 27 03:50:00 vm01 systemd[1]: mysql.service: Deactivat>
10月 27 03:50:00 vm01 systemd[1]: Stopped mysql.service - >
10月 27 03:50:00 vm01 systemd[1]: mysql.service: Consumed >
lines 1-16/16 (END)
```

- 再起動
```bash
sudo systemctl restart mysql
```  
```text
● mysql.service - MySQL Community Server
     Loaded: loaded (/usr/lib/systemd/system/mysql.service>
     Active: active (running) since Tue 2026-10-27 03:51:4>
    Process: 58519 ExecStartPre=/usr/share/mysql/mysql-sys>
   Main PID: 58527 (mysqld)
     Status: "Server is operational"
      Tasks: 38 (limit: 7966)
     Memory: 364.5M (peak: 378.5M)
        CPU: 1.194s
     CGroup: /system.slice/mysql.service
             └─58527 /usr/sbin/mysqld

10月 27 03:51:43 vm01 systemd[1]: Starting mysql.service ->
10月 27 03:51:44 vm01 systemd[1]: Started mysql.service - >
lines 1-14/14 (END)
```

- 自動起動確認
```bash
sudo systemctl enable mysql
```
```text
Synchronizing state of mysql.service with SysV service script with /usr/lib/systemd/systemd-sysv-install.
Executing: /usr/lib/systemd/systemd-sysv-install enable mysql
```

ディレクトリの例、  
```text
Ubuntu
 ├─ Spring Boot
 ├─ Thymeleaf
 └─ MySQL
```
の構成を一度作っておくと、実務でよく見るWebシステムの基本形を一通り経験できます。

#### mysql-server パッケージの状態を確認
```bash
apt policy mysql-server
```
```text
mysql-server:
  インストールされているバージョン: (なし)
  候補:               8.0.46-0ubuntu0.24.04.4
  バージョンテーブル:
     8.0.46-0ubuntu0.24.04.4 500
        500 http://jp.archive.ubuntu.com/ubuntu noble-updates/main amd64 Packages
        500 http://security.ubuntu.com/ubuntu noble-security/main amd64 Packages
     8.0.36-2ubuntu3 500
        500 http://jp.archive.ubuntu.com/ubuntu noble/main amd64 Packages
```
