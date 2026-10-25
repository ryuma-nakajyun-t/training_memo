# HTTPSの世界へ
## Spring Boot単体でHTTPS化へ

## 目的
- springboot環境を利用して、HTTPからHTTPSに変更方法を学ぶ.
- Linux上でセキュリティー関連の概念、トラブル、コマンドも同時に体感する.

## 項目一覧
1. 証明書作成
2. application.properties 作成
3. 起動
4. 確認  
   memo

### 1. 証明書作成
プロジェクトルートで実行
まずは、プロジェクトルートに移動
```bash
cd springboot-thymeleaf
```
確認
```bash
ls -l src/main/resources/keystore.p12
```
```bash
mkdir -p src/main/resources
```

```bash
keytool -genkeypair -alias springboot -keyalg RSA -keysize 2048 -storetype PKCS12 -keystore src/main/resources/keystore.p12 -validity 3650  -dname "CN=localhost, OU=Development, O=Sample, L=Tokyo, ST=Tokyo, C=JP"
```

パスワードは
例えば  
```text
password
```  
としておきます。  

確認
```bash
ls -l src/main/resources/keystore.p12
```

### 2. application.properties 作成
ディレクトリがなければ作成
```bash
ls - l src/main/resources
mkdir -p src/main/resources
touch src/main/resources/application.properties
```

application.properties  
```properties
server.port=8443
server.ssl.key-store=classpath:keystore.p12
server.ssl.key-store-password=your-password
server.ssl.key-store-type=PKCS12
server.ssl.key-alias=springboot
```

### 3. 起動
プロジェクトルートに移動
```bash
cd springboot-thymeleaf
```

```bash
mvn spring-boot:run
```
正常ならログに  
```text
Tomcat started on port 8443 (https)  
```
のような内容が出ます。  

### 4. 確認
IPアドレス確認
```bash
hostname -i
```
ブラウザ
```text 
https://localhost:8443/hello
```
コマンド
```bash
curl -k https://localhost:8443/hello
```

### 期待結果
Hello Spring Boot!

### Git管理する場合
.gitignore に追加しておくべき  
### SSL Certificate  
- *.p12  
- *.jks  

## 学習の次の段階(AIの提案ロードマップ)
今のリポジトリ構成なら
```text 
HTTP化
↓
HTTPS化
↓
application.properties理解
↓
REST API追加
↓
PostgreSQL接続
↓
Spring Security
```
の順が自然です。

### 注意すべきこと
特に HTTPS 化は「Spring Boot の設定変更だけで Tomcat の SSL が有効になる」ことを理解するのが目的で、  
実務ではその後に Nginx や AWS ALB を前段に置く構成へ進むことが多いです。  

### 参考
---
- AI先生  
- 

### 99.memo
--- 
- keytooltとは？？？
- mvn spring-boot:run とは
- 
