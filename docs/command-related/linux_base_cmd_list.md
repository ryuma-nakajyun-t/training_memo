# 常用Linuxコマンドなど
## Linux 基本コマンド
| 操作 | コマンド | 説明 |
| --- | --- | --- |
| ディレクトリ移動 | `cd DIR` | 指定ディレクトリへ移動 |
| 上の階層へ | `cd ..` | 親ディレクトリ |
| ホームへ | `cd` | ホームディレクトリ |
| ファイル一覧 | `ls -la` | 隠し含む詳細表示 |
| ファイル内容表示 | `cat FILE` | 内容表示 |
| 行番号付き表示 | `nl FILE` | 行番号付き表示 |
| ファイル検索 | `grep KEYWORD FILE` | キーワード検索 |
| 再帰検索 | `grep` -R `KEYWORD `DIR` | ディレクトリ全体検索 |
| プロセス一覧 | `ps `aux` | 全プロセス表示 |
| プロセス検索 | `ps aux | grep NAME` | プロセス絞り込み |
| メモリ状況 | `free` -h` | メモリ使用量 |
| ディスク使用量 | `df` -h` | ディスク容量 |
| ディレクトリ容量 | `du` -sh `DIR` | ディレクトリ容量 |
| SSH 接続 | `ssh` user@host` | リモートログイン |
| SSH 自動移動 | `RemoteCommand `cd `DIR; `exec `bash` -l` | 接続後に自動移動 |

## SSH・ネットワーク系コマンド
| 操作 | コマンド | 説明 |
| --- | --- | --- |
| SSH 接続 | `ssh` user@host` | リモートログイン |
| SSH 強制 TTY | `ssh` -t `user@host` | TTY を強制 |
| SSH 接続後に自動移動 | `RemoteCommand `cd `DIR; `exec `bash` -l` | 接続後に自動で cd |
| ポート指定 | `ssh` -p `22 `user@host` | ポート指定 |
| SCP（送信） | `scp` file `user@host:/path` | ファイル送信 |
| SCP（受信） | `scp` user@host:/path/file `.` | ファイル取得 |
| ポートフォワード | `ssh y-L` 8080:localhost:80 `user@host` | ローカル→リモート転送 |

# リダイレクトパターン一覧
## 基本リダイレクト
| 書き方 | 対象 | 動作 | 備考 |
| --- | --- | --- | --- |
| > file | stdout | 上書き | — |
| >> file | stdout | 追記 | — |
| 1> file | stdout | 上書き（明示） | — |
| 1>> file | stdout | 追記（明示） | — |
| 2> file | stderr | 上書き | — |
| 2>> file | stderr | 追記 | — |

## 捨てる系
| 書き方 | 対象 | 動作 |
| --- | --- | --- |
| > /dev/null | stdout | 捨てる |
| 2>/dev/null | stderr | 捨てる |
| &>/dev/null | stdout+stderr | 全部捨てる |

## 合流系（FD の向き先を揃える）
| 書き方 | 意味 | 補足 |
| --- | --- | --- |
| 2>&1 | stderr → stdout に合流 | — |
| 1>&2 | stdout → stderr に合流 | — |
| > file 2>&1 | 両方 file に出す | 正しい順番 | 
| 2>&1 > file | 意図通りにならない | stderr がターミナルへ向いたまま |

## ショートハンド（bash 限定）
| 書き方 | 意味 |
| --- | --- |
| &> file | stdout+stderr を file へ |
| &>> file | stdout+stderr を file に追記 |

## stdin 系
| 書き方 | 対象 | 動作 |
| --- | --- | --- |
| < file | stdin | ファイルを入力として読む |
| << EOF | stdin | ヒアドキュメント（複数行） |
| <<< "str" | stdin | ヒアストリング（1行） |

## 実務で頻出するパターン
| 用途 | 書き方 |
| --- | --- |
| ログを全部ファイルに保存 | command > out.txt 2>&1 |
| エラーだけ捨てる | command 2>/dev/null |
| 全部捨てる | command &>/dev/null |
| 正常出力とエラーを別ファイルに | command > result.txt 2> error.txt |
| スクリプトでエラー出力 | echo "error" 1>&2 |
| パイプに stderr も流す | `command` 2>&1 `next` |
