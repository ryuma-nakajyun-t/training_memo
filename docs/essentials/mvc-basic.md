# MVC
MVC は、Spring Bootで最も基本的な設計パターンの1つです。

一言でいうと、  
「画面表示」「業務処理」「データ」を分離する考え方
です。

MVCの全体像
```text
ブラウザ
   ↓
Controller
   ↓
Service
   ↓
Model
   ↓
Controller
   ↓
View(Thymeleaf)
   ↓
ブラウザ
```

M = Model  
データを表します。  
今回なら Customer が Model です。
```java
public class Customer {

    private Integer id;
    private String name;
    private Integer age;

}
```

CSV
1,Tanaka,20
↓
Model

Customer
 ├─ id = 1
 ├─ name = Tanaka
 └─ age = 20

V = View
画面です。
Thymeleaf が View に該当します。
```html
<tr th:each="customer : ${customers}">
    <td th:text="${customer.id}"></td>
    <td th:text="${customer.name}"></td>
    <td th:text="${customer.age}"></td>
</tr>
```
役割は
データを見やすく表示する
だけです。
CSV読込などはしません。

C = Controller
ブラウザからのリクエストを受け取ります。

```java
@Controller
public class CustomerController {

    @GetMapping("/customers")
    public String customers(Model model) {

        ....
    }
}
```

例えば
```text
http://localhost:8080/customers
```
へアクセスすると
```java
@GetMapping("/customers")
```
が呼ばれます。
Controllerは
受付係
みたいなものです。

今回の流れ
① ブラウザ
GET /customers

② Controller
```java
List<Customer> customers =
    customerService.loadCustomers();
```

Serviceに指示

顧客一覧を持ってきて

③ Service
```java
Files.lines(customer.csv)
```

CSVを読む

work/customer.csv

④ Model生成
Customer


へ変換

CSV
 ↓
Customer

⑤ Controllerへ返却
```java
model.addAttribute(
    "customers",
    customers
);
```

⑥ Viewへ渡す
customer-list.html

⑦ 画面表示
+----+--------+-----+
|ID  |名前    |年齢 |
+----+--------+-----+
|1   |Tanaka  |20   |
|2   |Suzuki  |30   |
+----+--------+-----+

なぜ分けるのか

もし全部1クラスでやると
```text
CSV読む
↓
画面表示する
↓
ファイル移動する
↓
HTML生成する
```
が混在します。

```java
public class CustomerController {

   CSV読込

   HTML生成

   ファイル移動

   業務処理

}
```
こうなると保守が大変です。

MVCなら
```text
Controller
受付

Service
業務処理
CSV読込
ファイル移動

Model
データ管理

View
画面表示
```
と役割を分離できます。

理解しやすいように業務システムに例えると、
```text
Controller
   = 現場リーダー

Service
   = 作業者

Model
   = 作業伝票

View
   = 報告書
```
です。

Spring Boot + Thymeleaf の学習ではまず
```text
Controller  
↓  
Service
↓
Model
↓
View
```
の流れを身体で覚えるのが重要です。  
今回のCSV読込アプリは MVC を学ぶ教材として非常に良い題材になっています。  


MVCの処理を図で示して
ControllerとServiceの違い
この構成の完成コードを見せて



# なぜMVCが生まれた？あとは歴史を
MVCが生まれた理由はシンプルです。  
「画面と処理をごちゃ混ぜにすると、大規模開発で破綻するから」
です。

MVC以前  
1970年代頃のシステムは、  
```text
画面表示
業務処理
データ処理
```
が1つのプログラムに書かれることが多かったです。

例えば、
```java
顧客検索
↓
DB検索
↓
結果表示
↓
画面入力チェック
```
全部同じ場所。

イメージ
```java
main() {

  DB検索

  HTML作成

  入力チェック

  更新処理

}
```
すると問題が発生します。

営業から  
画面を変更したい
と言われると、

開発者は
画面部分だけ触りたい
のに、
業務ロジックまで壊す
可能性が出ます。

## MVC誕生
1979年に  
Trygve Reenskaug  
が Smalltalk 向けにMVCを提案しました。  

考え方は非常にシンプル。

データ
処理
画面

を分けよう
です。

### Model
対象データ

顧客
商品
注文


など

Customer
Item
Order

### View

画面

一覧画面
詳細画面
入力画面


だけ担当

Controller

橋渡し役

画面から要求を受取る

↓

処理を呼ぶ

↓

結果を画面へ渡す

### MVCのメリット

例えば

顧客検索


があるとします。

画面デザイナー

画面を変更


Javaエンジニア

検索ロジックを変更


双方が独立して作業できるようになります。

Webシステム時代

1990年代になると

インターネット


が普及します。

すると

ブラウザ
↓
サーバ
↓
DB


という構造が主流になります。

そこでMVCが非常に相性が良かった。

ブラウザ
↓
Controller

業務処理
↓
Service

データ
↓
Model

画面
↓
View

Javaでの流れ
1997年

Servlet

doGet()


で全部処理

地獄になります。

HTML生成

SQL

業務ロジック


全部1ファイル。

JSP時代

画面を分離

Servlet
↓
JSP


になる。

Struts時代

2000年代

MVCが本格普及

Action
↓
Service
↓
DAO


という構成が一般化。

Spring MVC

2000年代後半

Spring Framework登場。

さらにMVCを綺麗に実装できる。

@Controller

Spring Boot

2014年頃から普及。

MVCがさらに簡単になる。

今の構成ですね。

Controller
↓
Service
↓
Repository
↓
DB


または

Controller
↓
Service
↓
CSV

あなたのCSVサンプルでのMVC

今回の構成を当てはめると

Model
Customer


CSVデータを表現

View
customer-list.html


画面表示

Controller
CustomerController


受付係

Service
CustomerService


CSV読込

CSV移動

業務処理

実は Spring Boot の現場では、

MVC
↓
Service層追加


した

Controller
↓
Service
↓
Model
↓
View


がよく使われます。

そのため隆磨さんが作ろうとしている

CSV読込
↓
一覧表示
↓
処理済みへ移動


のサンプルは、

単なるファイル読込ではなく

「Spring BootのMVCアーキテクチャを学ぶ教材」

として非常に良い題材です。

さらに歴史の流れで見ると、

全部入りプログラム
↓
MVC誕生
↓
Servlet
↓
JSP
↓
Struts
↓
Spring MVC
↓
Spring Boot


という進化の延長線上に、今のSpring Boot + Thymeleafがあります。

- MVCと三層アーキテクチャの違い
- ServletからSpring Bootまで詳しく
- MVCの設計思想を図解して
