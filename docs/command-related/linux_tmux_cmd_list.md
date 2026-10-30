# tmuxコマンド
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
