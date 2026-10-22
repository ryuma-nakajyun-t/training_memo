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

## tmux セッション管理
| 操作 | コマンド | 説明 | ショートカット | 
| --- | --- | --- | --- | 
| セッション一覧 | `tmux ls` | 既存セッション確認 | — |
| 新規セッション | `tmux new-session -s NAME` | 名前付きセッション作成 | — |
| 新規セッション（bash） | `tmux new-session "bash"` | bash 起動で開始 | — |
| セッションに入る | `tmux attach -t NAME` | 指定セッションへ接続 | — |
| セッション切替 | `tmux switch-client -t NAME` | 別セッションへ移動 | — |
| セッション削除 | `tmux kill-session -t NAME` | セッション終了 | — |
| 全削除 | `tmux kill-server` | tmux 全体終了 | — |

## tmux ウィンドウ管理 
| 操作 | コマンド | 説明 | ショートカット | 
| --- | --- | --- | --- |
| 新規ウィンドウ | `new-window` | 新しいウィンドウ作成 | prefix + `c` |
| 次のウィンドウ | `next-window` | 次へ移動 | prefix + `n` |
| 前のウィンドウ | `previous-window` | 前へ移動 | prefix + `p` |
| ウィンドウ一覧 | `list-windows` | 一覧表示 | prefix + `w` |
| ウィンドウ名変更 | `rename-window` | 名前変更 | prefix + `,` |
| ウィンドウ削除 | `kill-window` | ウィンドウ終了 | prefix + `&` |

## tmux ペイン（画面分割）
| 操作 | コマンド | 説明 | ショートカット |
| --- | --- | --- | --- |
| 左右分割（水平） | `split-window -h` | 左右に分割 | prefix + `%` |
| 上下分割（垂直） | `split-window -v` | 上下に分割 | prefix + `"` |
| 比率指定分割 | `split-window -h -p 30` | 幅 30% で右側に作成 | — |
| ペイン移動 | `select-pane -L/R/U/D` | ペイン間移動 | prefix + ←→↑↓ |
| サイズ変更 | `resize-pane -L/R/U/D` | ペインサイズ調整 | prefix + Ctrl + ←→↑↓ |
| 最大化（toggle） | `resize-pane -Z` | ペイン全画面化 | prefix + `z` |
| ペイン削除 | `kill-pane` | ペイン終了 | prefix + `x` |
| ペインを別ウィンドウへ移動 | `break-pane` | ペインを独立ウィンドウ化 | prefix + `!` |
| ペインを結合 | `join-pane -s SRC -t DEST` | ペインを別ウィンドウへ結合 | — |
| レイアウト整形（左右） | `select-layout even-horizontal` | 左右整形 | prefix + `M-1` |
| レイアウト整形（上下） | `select-layout even-vertical` | 上下整形 | prefix + `M-2` |
| グリッド整形 | `select-layout tiled` | タイル状に整形 | prefix + `M-3` |

## tmux その他の便利操作
| 操作 | コマンド | 説明 | ショートカット |
| --- | --- | --- | --- |
| コピーモード開始 | `copy-mode` | スクロール・コピー | prefix + `[` |
| コピーモード終了 | — | copy-mode を抜ける | `q` |
| ペースト | `paste-buffer` | バッファ貼り付け | prefix + `]` |
| バッファ一覧 | `list-buffers` | コピー履歴確認 | — |
| バッファ削除 | `delete-buffer -b N` | バッファ削除 | — |
| リロード | `source-file ~/.tmux.conf` | 設定再読み込み | prefix + `r` |
