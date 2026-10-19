# ワンライナーについてまとめる
## ワンライナーの流れ
- 入力（Input）→ 対象を列挙する → find, ls, cat
- 抽出（Filter）→ 必要なものだけ取り出す → grep
- 変換（Transform） → 整形・加工する → cut, sed, awk
- 出力（Output） → 見やすくする・集計する → sort, uniq, wc, head

## [Prometheus](https://github.com/ryuma-nakajyun/prometheus)リポジトリで実際に使えるワンライナー(練習として採用をさせていただきます。)
1. 構造把握（ls / find）
2. 抽出（grep）
3. Go 特化（関数・import・error）
4. Prometheus 特化（promql / tsdb / scrape / web）
5. CI / ビルド（Makefile / scripts）

## 1. 構造把握（ls / find）
| コマンド | 説明 |
| --- | --- |
| ls | カレントディレクトリのファイル一覧を表示する基本コマンド |
| ls -1 | 1 行 1 ファイルで一覧を表示（スクリプト向け） | 
| ls **/*.go | カレント以下のすべての `.go` ファイルを表示（glob） |
| ls **/*.md | Markdown ファイルを一覧表示 | 
| ls **/*.yaml | YAML ファイルを一覧表示 | 
| ls */ | 直下のディレクトリ一覧を表示 | 
| ls -lt | 更新時刻順（新しい順）でファイルを並べる | 
| ls -R | 再帰的にディレクトリ構造を表示（ツリー状） | 
| find . -type f | すべてのファイルを再帰的に列挙 | 
| find . -type d | すべてのディレクトリを再帰的に列挙 | 
| find . -maxdepth 1 -type f | カレント直下のファイルのみ列挙（再帰しない） | 
| find . -name '*.go' | `.go` ファイルを再帰的に検索 | 
| find . -name '*.md' | `.md` ファイルを再帰的に検索 | 
| find . -name '*.yaml' -o -name '*.yml' | YAML ファイル（拡張子 2 種）を検索 | 
| find . -name '*test*.go' | テスト関連の Go ファイルを検索 | 
| find . -empty | 空ディレクトリ・空ファイルを検索 | 
| find . -type f -size +1M | 1MB を超える大きなファイルを検索 | 
| find . -mtime -1 | 24 時間以内に更新されたファイルを検索 | 
| find . -name '*.go' -print0 | NULL 区切りで `.go` ファイルを出力（xargs -0 用） | 
| find . -name '*.go' | wc -l | `.go` ファイルの総数をカウント | 

## 2. 抽出（grep）
| コマンド | 説明 |
| --- | --- |
| grep -R TODO . | TODO コメントを再帰的に検索 | 
| grep -R error . | error を含む行を検索（エラー箇所の抽出） | 
| grep -R '^func ' . | 関数定義行を抽出 | 
| grep -R 'promql' . | promql を含む行を検索 | 
| grep -R 'tsdb' . | tsdb を含む行を検索 | 
| grep -R 'scrape' . | scrape を含む行を検索 | 
| grep -R 'target' . | target を含む行を検索 | 
| grep -R 'alert' . | alert を含む行を検索 | 
| grep -R 'metric' . | metric を含む行を検索 | 
| grep -R 'Prometheus' . | Prometheus を含む行を検索 | 
| grep -R 'import (' . | import ブロックを含む行を抽出 | 
| grep -R 'context' . | context を含む行を検索 | 
| grep -R 'http' . | http を含む行を検索 | 
| grep -R 'grpc' . | grpc を含む行を検索 | 
| grep -R 'json' . | json を含む行を検索 | 
| grep -R 'yaml' . | yaml を含む行を検索 | 
| grep -R 'flag' . | flag パッケージ利用箇所を検索 | 
| grep -R 'main(' . | main 関数を含む行を検索 | 
| grep -R 'New' . | New で始まるコンストラクタ的関数を検索 | 
| grep -R 'interface{' . | interface 定義を検索 | 

## 3. Go 特化（関数・import・error）
| コマンド | 説明 |
| --- | --- |
| grep -R '^func ' -n . | 関数定義を行番号付きで抽出 |
| grep -R '^type ' -n . | type 定義を抽出 |
| grep -R '^var ' -n . | var 宣言を抽出 |
| grep -R '^const ' -n . | const 宣言を抽出 |
| grep -R 'struct{' -n . | struct 定義を抽出 |
| grep -R 'interface{' -n . | interface 定義を抽出 |
| grep -R 'error' -n . | error を含む行を抽出 |
| grep -R 'panic' -n . | panic を含む行を抽出 |
| grep -R 'log\.' -n . | log パッケージ利用箇所を抽出 |
| grep -R 'fmt\.' -n . | fmt パッケージ利用箇所を抽出 |
| grep -R 'context' -n . | context パッケージ利用箇所を抽出 |
| grep -R 'go func' -n . | goroutine の匿名関数を抽出 |
| grep -R 'select {' -n . | select 文を抽出 |
| grep -R 'for {' -n . | for 文を抽出 | 
| grep -R 'if err' -n . | エラーハンドリング箇所を抽出 |
| grep -R 'return nil' -n . | nil を返す箇所を抽出 |
| grep -R 'defer ' -n . | defer 文を抽出 |
| grep -R 'sync\.' -n . | sync パッケージ利用箇所を抽出 |
| grep -R 'time\.' -n . | time パッケージ利用箇所を抽出 |
| grep -R 'http\.' -n . | net/http の利用箇所を抽出 |

## 4. Prometheus 特化（promql / tsdb / scrape / web）
| コマンド | 説明 |
| --- | --- |
| grep -R 'promql' -n . | promql 関連コードを抽出 |
| grep -R 'parser' ./promql | promql パーサ部分を検索 |
| grep -R 'engine' ./promql | promql 実行エンジン部分を検索 |
| grep -R 'tsdb' -n . | tsdb 関連コードを抽出 |
| grep -R 'block' ./tsdb | tsdb の block 処理を検索 |
| grep -R 'wal' ./tsdb | tsdb の WAL 処理を検索 |
| grep -R 'scrape' -n . | scrape 関連コードを抽出 |
| grep -R 'target' ./scrape | scrape の target 処理を検索 |
| grep -R 'discovery' ./discovery | サービスディスカバリ関連コードを検索 |
| grep -R 'alert' ./rules | alert 関連コードを抽出 |
| grep -R 'rule' ./rules | rule 関連コードを抽出 |
| grep -R 'storage' . | storage 関連コードを抽出 |
| grep -R 'remote' . | remote write/read 関連コードを抽出 |
| grep -R 'web' . | web サーバ関連コードを抽出 |
| grep -R 'ui' ./web | UI 関連コードを抽出 |
| grep -R 'api' . | API ハンドラ関連コードを抽出 |
| grep -R 'metrics' . | metrics 関連コードを抽出 |
| grep -R 'collector' . | collector 実装を抽出 |
| grep -R 'instrument' . | 計測（instrumentation）コードを抽出 |
| grep -R 'registry' . | registry 関連コードを抽出 |

## 5. CI / ビルド（Makefile / scripts）
| コマンド | 説明 |
| --- | --- |
| grep -E '^[a-zA-Z0-9_-]+:' Makefile | Makefile のターゲット一覧を抽出 |
| grep -R 'docker' . | docker 関連コード・設定を検索 |
| grep -R 'build' . | build 関連処理を検索 |
| grep -R 'lint' . | lint 関連処理を検索 |
| grep -R 'test' . | test 関連処理を検索 |
| grep -R 'go build' . | go build を呼び出す箇所を検索 |
| grep -R 'go test' . | go test を呼び出す箇所を検索 |
| grep -R 'go vet' . | go vet を呼び出す箇所を検索 |
| grep -R 'shell' ./scripts | shell を含むスクリプトを検索 |
| grep -R 'bash' ./scripts | bash を含むスクリプトを検索 |

## メタ解析（ランキング・集計）
| コマンド | 説明 |
| --- | --- |
| grep -R TODO . | cut -d: -f1 | sort | uniq -c | sort -nr | TODO が多いファイルをランキング |
| grep -R error . | cut -d: -f1 | sort | uniq -c | sort -nr | error が多いファイルをランキング |
| grep -R '^func ' . | cut -d: -f1 | sort | uniq -c | sort -nr | 関数定義が多いファイルをランキング |
| find . -name '*.go' | sed 's|/[^/]*$||' | sort | uniq -c | sort -nr | Go ファイル数が多いディレクトリをランキング |
| wc -l **/*.go | sort -nr | head -20 | 行数が多い Go ファイル TOP20 |
| grep -R 'import (' -n . | cut -d: -f1 | sort | uniq -c | sort -nr | import ブロックが多いファイルをランキング |
| grep -R 'panic' . | cut -d: -f1 | sort | uniq -c | sort -nr | panic が多いファイルをランキング |
| grep -R 'context' . | cut -d: -f1 | sort | uniq -c | sort -nr | context 利用が多いファイルをランキング |
| grep -R 'http' . | cut -d: -f1 | sort | uniq -c | sort -nr | http 利用が多いファイルをランキング |
| grep -R 'New' . | cut -d: -f1 | sort | uniq -c | sort -nr | New 関数が多いファイルをランキング |
