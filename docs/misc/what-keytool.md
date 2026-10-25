# keytool の基礎基本
keytool は、Javaの証明書・秘密鍵を管理するための標準ツールです。

あなたが今学んでいる
```text
HTTP
↓
HTTPS
↓
TLS
↓
証明書
```
の「証明書」の部分を扱うのが keytool です。

まず全体像  
HTTPS通信では、
```text
サーバー
↓
私は本物です
```
を証明する必要があります。

そのために使うのが  
```text
秘密鍵
公開鍵
証明書
```
です。

keytool はこれらを管理します。  
```text
keytoolが扱うもの
秘密鍵（Private Key）
サーバーだけが持つ鍵
絶対に外部へ渡さない
公開鍵（Public Key）
誰に見られてもよい鍵
ブラウザへ渡す
証明書（Certificate）
公開鍵を含む身分証明書
この公開鍵は本物ですよ
を証明するもの
キーストアとは
keytoolで最も重要なのが
Keystore
```
です。

イメージ
```text
金庫
 ├─ 秘密鍵
 ├─ 公開鍵
 └─ 証明書
```

Spring Bootでは
```text
keystore.p12
```
のようなファイルになります。

よく使うコマンド  
① キーストア作成
```bash
keytool -genkeypair \
-alias myserver \
-keyalg RSA \
-keystore keystore.p12 \
-storetype PKCS12
```

実行すると
```text
秘密鍵
証明書
```
が作成されます。

② キーストアの確認
keytool -list -keystore keystore.p12  
例
```test
Your keystore contains 1 entry
myserver
```

③ 証明書の確認
keytool -printcert -file server.crt  
例
```text
Owner:
Issuer:
Valid from:
```
などが表示されます。

④ 証明書を取り出す
```bash
keytool -exportcert \
-alias myserver \
-keystore keystore.p12 \
-file server.crt
```
Spring Bootとの関係  
例えば
```text
# HTTPSで待ち受けるポート番号
# 開発環境では8443を使うことが多い
server.port=8443

# SSL/TLS(HTTPS)を有効化する
# falseならHTTP通信になる
```text
server.ssl.enabled=true

# サーバー証明書と秘密鍵が格納された
# キーストアファイルの場所
# classpath は src/main/resources を指す
server.ssl.key-store=classpath:keystore.p12

# キーストアを開くためのパスワード
server.ssl.key-store-password=password

# キーストアの形式
# PKCS12(.p12/.pfx)が現在の主流
server.ssl.key-store-type=PKCS12
```
を設定すると
```bash
mvn spring-boot:run
```
でHTTPS起動できます。

通信の流れ
ブラウザから
```text
https://localhost:8443/hello
```
へアクセスすると
```text
ブラウザ
 ↓
証明書ください
 ↓
Spring Boot
 ↓
keystore.p12から証明書取得
 ↓
ブラウザへ送信
 ↓
TLS確立
 ↓
HTTP通信開始
```
となります。

現場で頻出のオプション
```text
-genkeypair

鍵作成

keytool -genkeypair

-list

一覧表示

keytool -list

-exportcert

証明書出力

keytool -exportcert

-importcert

証明書取込

keytool -importcert
```
実務で覚えるべき最低限

まずはこれだけで十分です。
```text
keytool
 ↓
keystoreを作る

keystore
 ↓
秘密鍵と証明書を保存

Spring Boot
 ↓
keystoreを読み込む

ブラウザ
 ↓
HTTPS通信できる
```

あなたが今見ている
```text
https://localhost:8443/hello
```

は、まさにこの仕組みの上で動いています。

次に学ぶなら、
```text
keytool
 ↓
証明書
 ↓
TLSハンドシェイク
 ↓
HTTPS
```

の流れを理解すると、HTTPから一段上のネットワーク理解につながります。


### 参考
---
- AI先生  
- 

### 99.memo
--- 
- mvn spring-boot:run とは
- 
- 