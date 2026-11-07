# Google Java Style版も作成して
Google Java Style は Eclipse 標準フォーマッターだけでは 100% 再現できません。  
通常は google-java-format プラグインを使います。  

ただし、Eclipse Formatter で近似する XML は作れます。  
google-java-style.xml  
```xml
<?xml version="1.0" encoding="UTF-8"?>
<profiles version="21">
  <profile kind="CodeFormatterProfile"
           name="GoogleJavaStyle"
           version="21">

    <!-- ===================================================== -->
    <!-- 基本設定                                               -->
    <!-- ===================================================== -->
    <!-- 1行の最大文字数（Google Java Styleは100文字推奨） -->
    <setting id="org.eclipse.jdt.core.formatter.lineSplit" value="100"/>

    <!-- ===================================================== -->
    <!-- インデント設定                                         -->
    <!-- ===================================================== -->
    <!-- タブではなくスペースを使用 -->
    <setting id="org.eclipse.jdt.core.formatter.tabulation.char" value="space"/>

    <!-- タブサイズ -->
    <setting id="org.eclipse.jdt.core.formatter.tabulation.size" value="2"/>

    <!-- インデントサイズ -->
    <setting id="org.eclipse.jdt.core.formatter.indentation.size" value="2"/>

    <!-- ===================================================== -->
    <!-- 波括弧（ブレース）設定                                 -->
    <!-- ===================================================== -->
    <!-- クラス宣言 -->
    <setting id="org.eclipse.jdt.core.formatter.brace_position_for_type_declaration"
             value="end_of_line"/>

    <!-- メソッド宣言 -->
    <setting id="org.eclipse.jdt.core.formatter.brace_position_for_method_declaration"
             value="end_of_line"/>

    <!-- コンストラクタ宣言 -->
    <setting id="org.eclipse.jdt.core.formatter.brace_position_for_constructor_declaration"
             value="end_of_line"/>

    <!-- if, for, while等のブロック -->
    <setting id="org.eclipse.jdt.core.formatter.brace_position_for_block"
             value="end_of_line"/>

    <!-- ===================================================== -->
    <!-- 改行・折り返し設定                                     -->
    <!-- ===================================================== -->
    <!-- メソッド呼び出し引数 -->
    <setting id="org.eclipse.jdt.core.formatter.alignment_for_arguments_in_method_invocation"
             value="16"/>

    <!-- new時のコンストラクタ引数 -->
    <setting id="org.eclipse.jdt.core.formatter.alignment_for_arguments_in_allocation_expression"
             value="16"/>

    <!-- メソッド宣言の引数 -->
    <setting id="org.eclipse.jdt.core.formatter.alignment_for_parameters_in_method_declaration"
             value="16"/>

    <!-- コンストラクタ宣言の引数 -->
    <setting id="org.eclipse.jdt.core.formatter.alignment_for_parameters_in_constructor_declaration"
             value="16"/>

    <!-- メソッドチェーン -->
    <setting id="org.eclipse.jdt.core.formatter.alignment_for_selector_in_method_invocation"
             value="16"/>

    <!-- ===================================================== -->
    <!-- 1行圧縮防止                                            -->
    <!-- ===================================================== -->
    <!-- ifを1行にしない -->
    <setting id="org.eclipse.jdt.core.formatter.keep_simple_if_on_one_line"
             value="false"/>

    <!-- then節を同一行にしない -->
    <setting id="org.eclipse.jdt.core.formatter.keep_then_statement_on_same_line"
             value="false"/>

    <!-- forを1行にしない -->
    <setting id="org.eclipse.jdt.core.formatter.keep_simple_for_body_on_same_line"
             value="false"/>

    <!-- whileを1行にしない -->
    <setting id="org.eclipse.jdt.core.formatter.keep_simple_while_body_on_same_line"
             value="false"/>

    <!-- do whileを1行にしない -->
    <setting id="org.eclipse.jdt.core.formatter.keep_simple_do_while_body_on_same_line"
             value="false"/>

    <!-- ===================================================== -->
    <!-- スペース設定                                           -->
    <!-- ===================================================== -->
    <!-- メソッド引数のカンマ後にスペースを入れる -->
    <setting id="org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_invocation_arguments"
             value="insert"/>

    <!-- メソッド定義引数のカンマ後にスペースを入れる -->
    <setting id="org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_declaration_parameters"
             value="insert"/>

    <!-- ブロック開始前にスペース -->
    <setting id="org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_block"
             value="insert"/>

    <!-- メソッド開始前にスペース -->
    <setting id="org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_method_declaration"
             value="insert"/>

    <!-- クラス開始前にスペース -->
    <setting id="org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_type_declaration"
             value="insert"/>

    <!-- ===================================================== -->
    <!-- コメント設定                                           -->
    <!-- ===================================================== -->
    <!-- 通常コメント整形 -->
    <setting id="org.eclipse.jdt.core.formatter.comment.format_comments"
             value="true"/>

    <!-- JavaDoc整形 -->
    <setting id="org.eclipse.jdt.core.formatter.comment.format_javadoc_comments"
             value="true"/>

    <!-- コメントの折り返し文字数 -->
    <setting id="org.eclipse.jdt.core.formatter.comment.line_length"
             value="100"/>

    <!-- ===================================================== -->
    <!-- 空行設定                                               -->
    <!-- ===================================================== -->
    <!-- メソッド前の空行数 -->
    <setting id="org.eclipse.jdt.core.formatter.blank_lines_before_method"
             value="1"/>

    <!-- 内部クラス前の空行数 -->
    <setting id="org.eclipse.jdt.core.formatter.blank_lines_before_member_type"
             value="1"/>

    <!-- ===================================================== -->
    <!-- アノテーション設定                                     -->
    <!-- ===================================================== -->
    <!-- フィールド注釈後に改行 -->
    <setting id="org.eclipse.jdt.core.formatter.insert_new_line_after_annotation_on_field"
             value="insert"/>

    <!-- メソッド注釈後に改行 -->
    <setting id="org.eclipse.jdt.core.formatter.insert_new_line_after_annotation_on_method"
             value="insert"/>

    <!-- クラス注釈後に改行 -->
    <setting id="org.eclipse.jdt.core.formatter.insert_new_line_after_annotation_on_type"
             value="insert"/>
  </profile>
</profiles>
```

ただし実務ならこちらがおすすめ
Google社が提供している google-java-format を Eclipse に導入すると、チーム全員が同じ形式になります。

フォーマット前  
```java
public void execute(String userId,String name,String email){
}
```
フォーマット後  
```java
public void execute(
    String userId,
    String name,
    String email) {}
```

あなたの場合は Spring Boot の学習やポートフォリオ作成が多いので、  
- 個人開発 → 自作 Formatter（引数ごと改行）
- 現場案件 → Google Java Style
- Spring チーム → Spring Java Format  
の3つを使い分けるのがおすすめです。  
特に現場では「自分の好み」より「チーム規約に合わせる能力」の方が評価されやすいです。  

- 関連の質問
  - 完全なGoogle Java Format導入手順
  - Eclipse用の正確なXMLを作成して
  - IntelliJ用設定にも変換して



# このXMLがEclipseで使えるか確認して
結論から言うと、その XML は「XMLとしては正しい」ですが、  
Eclipse の Formatter としてはそのまま使えない可能性が高いです。  

理由は、Eclipse の Formatter XML には非常に多くの設定項目があり、  
alignment_for_arguments_in_method_invocation などの値も単純な数値ではなく  
Eclipse 独自のビットフラグになっています。  

例えば、
```xml
<setting
    id="org.eclipse.jdt.core.formatter.alignment_for_arguments_in_method_invocation"
    value="16"/>
```

この 16 が
- Eclipse 2024-03
- Eclipse 2024-06
- Eclipse 2025-03
で期待通りに解釈される保証はありません。

また、
```xml
<setting
    id="org.eclipse.jdt.core.formatter.insert_new_line_after_annotation_on_method"
    value="insert"/>
```

のような設定も、Eclipseのバージョンによっては ID が存在しない場合があります。  

確実な確認方法  
Eclipseで  
```text
Window
↓
Preferences
↓
Java
↓
Code Style
↓
Formatter
↓
New...
```
適当にプロファイルを作成し  
Export All...  
を押します。  

すると Eclipse が認識している
```xml
<?xml version="1.0" encoding="UTF-8"?>
<profiles version="23">
```
のような完全な XML が出力されます。  

その XML をベースに編集すれば、  
- Eclipseが認識する設定ID
- Eclipseが認識する値
- Eclipseのバージョン  
がすべて一致します。

私が見た限りの問題点  
この XML は  
- alignment_for_arguments_in_method_invocation
- alignment_for_selector_in_method_invocation
など最低限の項目しかないため、

フォーマットしても
```java
public class Sample{
public void test(){
System.out.println("test");
}
}
```
のようなコードは意図した Google Style にはなりません。  

Google Java Style を再現するには実際は
- Google Java Style
  - insert_space_before_comma...
  - insert_space_after_comma...
  - blank_lines...
  - parentheses...
  - switch...
  - lambda...
  - record...
  - annotation...  
など数百項目必要です。

現場でのおすすめ
- Google Java Style を使うなら Formatter XML を自作するより
- google-java-format プラグイン
を導入した方が確実です。
```java
Ctrl + Shift + F
```
だけで Google が定義するスタイルになります。

Eclipse Formatter XML は  
- 自分専用
- チーム独自ルール
のときに作るものです。  
Google Style を目指すなら Google の formatter をそのまま使う方が保守しやすいです。

ちなみに、あなたが本当に「完全版 XML」を作りたいなら、  
現在使っている Eclipse のバージョン（2024-06、2024-09、2025-03 など）を教えてもらえれば、  
そのバージョンでエクスポートした形式に合わせた XML の骨格を作れます。  



# このxmlを配置手順を示して
Eclipse に Formatter XML を配置する手順です。

### 1. XMLファイルを保存
例えば以下の名前で保存します。
```text
google-java-style.xml
```
保存場所の例
```text
C:\work\eclipse\formatter\google-java-style.xml
```
または
```text
~/workspace/eclipse/formatter/google-java-style.xml
```

### 2. Eclipseを起動
メニューから
Window
↓
Preferences
を開きます。

### 3. Formatter設定画面へ移動
```text
Java
↓
Code Style
↓
Formatter
```

### 4. XMLをインポート
右側の  
Import..  .
をクリックします。  
保存した  
google-java-style.xml  
を選択します。

### 5. Formatterを有効化
一覧に  
GoogleJavaStyle  
が表示されるので選択します。  
Apply and Close  
を押します。  

### 6. 動作確認
テストコード  
```java
public class Sample{
public void test(String userId,String name,String email){
System.out.println(userId);
}
}
```
を開きます。  

### 7. フォーマット実行  
ショートカット
```text
Windows
Ctrl + Shift + F

Linux
Ctrl + Shift + F
```

### 8. Formatterが適用されることを確認
```java
public class Sample {

  public void test(
      String userId,
      String name,
      String email) {

    System.out.println(userId);
  }
}
```

のように整形されれば成功です。

インポート時にエラーになる場合

次のようなエラーが出ることがあります。

Failed to import profile


または

Unknown setting


その場合は XML の問題ではなく、

Eclipse のバージョンが古い
XML の version="21" が合わない
Formatter設定IDがそのバージョンに存在しない

可能性があります。

そのときは Eclipse で一度
```text
Window
↓
Preferences
↓
Java
↓
Code Style
↓
Formatter
↓
New...
↓
Export All...
```

を実行し、Eclipseが出力したXMLをベースに編集すると確実です。  

特にあなたは Spring Boot の学習をしているので、  
実務向けなら Formatter XML を自作するより Google Java Format プラグインや   
Spring Java Format を導入する方が再現性が高く、チーム開発でも有利 です。  


# エクリプスのフォーマッターのファイルはどこにあるの？
Eclipse のフォーマッターは、実は「ファイルとしてどこかに保存されている」とは限りません。

主に3パターンあります。
### ① Eclipse内部に保存されている（通常）

Formatter を作成すると、
```text
Window
↓
Preferences
↓
Java
↓
Code Style
↓
Formatter
```
の設定領域に保存されます。

この場合、  
formatter.xml  
のようなファイルは存在しません。  

### ② ExportしたXMLファイル
Formatter画面の
Export All...
を押した場合のみ
google-java-style.xml
などのファイルとして保存されます。

例えば

C:\Users\ユーザー名\Documents\eclipse

や

~/workspace/config/


など自分で指定した場所です。

### ③ EclipseのWorkspace内

Workspace設定として保存されている場合は

workspace/.metadata/

配下にあります。
例
```text
workspace/
└─ .metadata/
   └─ .plugins/
```

ただし、

設定は Eclipse の内部形式で保存されており、
```text
formatter.xml
```
という名前ではありません。

そのため直接編集するのはおすすめしません。

Linux(Ubuntu)の場合

ワークスペース例

~/workspace


なら
```bash
cd ~/workspace/.metadata
find . | grep -i formatter
```
で関連ファイルを探せます。

一番確実な確認方法
現在使っている Formatter を XML 化したいなら
``````text
Window
↓
Preferences
↓
Java
↓
Code Style
↓
Formatter
↓
Export All...
```
を実行してください。
すると Eclipse が認識している完全な Formatter 設定が XML として出力されます。

案件で配布するなら、この Export した XML を Git 管理するのが一般的です。
```text
project-root/
├─ .settings/
├─ src/
└─ formatter/
   └─ eclipse-formatter.xml
```
のような構成をよく見かけます。


### 関連質問
- 設定をXMLとしてエクスポートする方法
- ワークスペース内の設定場所を確認して
- プロジェクトにFormatterを共有する方法


# エクリプスは設定関連が難しい
それ、かなり多くの人が感じます。

Eclipse は歴史が長い分、
```text
Java
 └ Code Style
     └ Formatter
         └ Edit
             └ Line Wrapping
```
みたいに設定が深くて、
さらに
```text
alignment_for_arguments_in_method_invocation
brace_position_for_method_declaration
```
のような内部設定名まで出てくるので、初学者にはかなり厳しいです。

実際、Java現場でも
```text
Eclipseを長年使っている人
Formatter担当者
テックリード
```
以外は、  
チームから渡されたXMLをImportするだけ
ということが多いです。

あなたの今の段階なら  
設定を深追いするより、
```text
① FormatterをImportできる
↓
② Ctrl + Shift + F を使える
↓
③ チームFormatterに従える
```
ここまでできれば十分です。

なぜ難しいのか

Eclipseは元々
```text
IDE
↓
プラグインで拡張
↓
さらに設定を細かく変更
```
という思想です。

そのため
```text
VSCode
→ シンプル

IntelliJ
→ ある程度隠蔽

Eclipse
→ 全部見せる
```
という違いがあります。

現場で本当に重要なこと

意外ですが、

Formatterを作れる


より

Formatterを合わせられる


方が大事です。

例えば案件に入ったら

formatter.xml
checkstyle.xml
spotbugs

が渡され、
これ使ってください
で終わることが多いです。

あなたの場合
最近の会話を見ると

Spring Boot
MySQL
Ansible
Linux

を学んでいますが、

正直なところ、
```text
Formatter設定を1日調べる
```
より
```text
Spring BootでCRUDを1本作る
```

方が市場価値への効果は大きいです。

Linuxのファイルシステムを深掘りしたときと同じで、

「仕組みを理解したい」というあなたの強みが出ていますが、Formatterは実務では

Importする
↓
使う

で済ませる人が大半です。
なので今回は
- Formatter XMLをImportできた
- Formatterの場所を理解した
-  Ctrl + Shift + Fで整形できる

まで理解したら十分だと思います。むしろ今は Spring Boot や SQL の方が投資対効果が高いですね。

### 関連質問
- Eclipse設定を簡単に覚える手順
- Spring Bootの学習計画を作って
- Formatterの最低限だけ教えて

# Formatterの最低限だけ教えて
最低限なら、Formatter は 3つだけ覚えれば十分 です。
### ① Formatterを適用する
ショートカット

Ctrl + Shift + F


これが一番重要です。

例えば
```java
if(flag){
System.out.println("test");
}
```
↓
```java
if (flag) {
    System.out.println("test");
}
```

### ② インデントを4スペースにする
```text
Window
↓
Preferences
↓
Java
↓
Code Style
↓
Formatter
↓
Edit
↓
Indentation
```

設定
```text
Tab policy       : Spaces only
Indentation size : 4
```
現場でもよく見る設定です。

### ③ 行幅を120文字にする
Formatter
↓
Edit
↓
Line Wrapping


設定
```text
Maximum line width : 120
```

長いコードの改行位置を決める基準です。

まず理解しなくていいもの
今の段階では以下は無視してOKです。
- alignment_for_...
- brace_position_for_...
- insert_space_before...
- insert_new_line_after...
これらはチームのXMLをImportすると自動で設定されます。

実務での優先順位

覚えるべき順番は
- ① Ctrl + Shift + F
- ② Formatter XMLをImportできる
- ③ インデント4スペースを理解
- ④ 行幅120を理解
- ⑤ それ以外は必要になったら調べる
です。

正直、Spring Boot案件なら「Formatterの詳細設定を作れる」よりも、  
- Controller
- Service
- Repository
- SQL
- Git
を理解している方が何倍も評価されます。  
なので Formatter は 「整形できる」「Importできる」までで十分 ですよ。  
