# Emacs Configuration

個人用 Emacs 設定ファイル。パッケージ管理には `use-package` を使用。

---

## セットアップ

```bash
git clone <this-repo> ~/.emacs.d
emacs
```

初回起動時にパッケージが自動インストールされます。完了後、以下を一度実行してください。

```
M-x nerd-icons-install-fonts
```

また Org ファイルの保存先ディレクトリを作成してください。

```bash
mkdir -p ~/org
```

---

## キーバインド一覧

### 基本操作

| キー | 動作 |
|---|---|
| `C-h` | バックスペース |

### ナビゲーション

| キー | 動作 | パッケージ |
|---|---|---|
| `C-s` | インクリメンタル検索 | swiper |
| `C-;` | 2文字でカーソルジャンプ | avy |
| `M-g g` | 行番号でジャンプ | avy |
| `C-x C-f` | ファイルを開く (候補一覧付き) | counsel |
| `C-x b` | バッファ切り替え | counsel |
| `M-x` | コマンド実行 (履歴・頻度ソート) | counsel + amx |

### ファイルツリー / 構造

| キー | 動作 | パッケージ |
|---|---|---|
| `C-c n` | ファイルツリーの表示/非表示 | neotree |
| `C-c i` | 関数・見出し一覧の表示/非表示 | imenu-list |

### LSP

| キー | 動作 | パッケージ |
|---|---|---|
| `C-c l` | LSP コマンドプレフィックス | lsp-mode |
| `C-c l r r` | シンボルのリネーム | lsp-mode |
| `C-c l g d` | 定義へジャンプ | lsp-mode |
| `C-c l g r` | 参照一覧 | lsp-mode |
| `C-c l a a` | コードアクション | lsp-mode |

### コード補完

| 操作 | 動作 | パッケージ |
|---|---|---|
| 自動ポップアップ | 補完候補を表示 | company |
| `TAB` / `RET` | 候補を選択・確定 | company |
| `C-g` | 補完を閉じる | company |

### Git

| キー | 動作 | パッケージ |
|---|---|---|
| `C-c g` | Magit ステータス画面を開く | magit |
| `s` | ファイルをステージ (Magit 内) | magit |
| `c c` | コミット (Magit 内) | magit |
| `P p` | push (Magit 内) | magit |
| `F p` | pull (Magit 内) | magit |
| `b b` | ブランチ切り替え (Magit 内) | magit |

### プロジェクト管理

| キー | 動作 | パッケージ |
|---|---|---|
| `C-c p` | Projectile コマンドプレフィックス | projectile |
| `C-c p f` | プロジェクト内ファイル検索 | projectile |
| `C-c p p` | プロジェクト切り替え | projectile |
| `C-c p s g` | プロジェクト内 grep | projectile |
| `C-c p k` | プロジェクトのバッファをすべて閉じる | projectile |

### Org-mode

| キー | 動作 | パッケージ |
|---|---|---|
| `C-c a` | アジェンダを開く | org |
| `C-c c` | クイックキャプチャ | org-capture |
| `C-c C-t` | TODO ステータスを切り替え | org |
| `C-c C-s` | スケジュールを設定 | org |
| `C-c C-d` | 締め切りを設定 | org |
| `P` | ポモドーロタイマー開始 (アジェンダ内) | org-pomodoro |

### ユーティリティ

| キー | 動作 | パッケージ |
|---|---|---|
| `C-c h f` | 関数のヘルプ (リッチ表示) | helpful |
| `C-c h v` | 変数のヘルプ (リッチ表示) | helpful |
| `C-c h k` | キーバインドのヘルプ (リッチ表示) | helpful |
| `C-x u` | undo ツリーを可視化 | undo-tree |

---

## 機能説明

### UI / テーマ

| パッケージ | 説明 |
|---|---|
| [doom-themes](https://github.com/doomemacs/themes) (doom-dracula) | ダークテーマ。Dracula カラーを採用 |
| [doom-modeline](https://github.com/seagle0128/doom-modeline) | アイコン付きのリッチなモードライン |
| [hide-mode-line](https://github.com/hlissner/emacs-hide-mode-line) | neotree・dashboard 等でモードラインを非表示 |
| [emacs-dashboard](https://github.com/emacs-dashboard/emacs-dashboard) | 起動時のダッシュボード。最近のファイル・プロジェクトを表示 |
| [minimap](https://github.com/dengste/minimap) | バッファ右端にコード全体のミニマップを表示 |
| [beacon](https://github.com/Malabarba/beacon) | スクロール時にカーソル位置をフラッシュして視認性向上 |
| [nerd-icons](https://github.com/rainstormstudio/nerd-icons.el) | doom-modeline / dashboard 等に使うアイコンフォント |

### ファイルツリー

| パッケージ | 説明 |
|---|---|
| [neotree](https://github.com/jaypei/emacs-neotree) | サイドバーにファイルツリーを表示。`C-c n` でトグル |
| [imenu-list](https://github.com/bmag/imenu-list) | 現在のバッファの関数・見出し一覧をサイドバーに表示。`C-c i` でトグル |

### 補完 / ナビゲーション

| パッケージ | 説明 |
|---|---|
| [ivy](https://github.com/abo-abo/swiper) | ミニバッファ補完フレームワーク。候補をインタラクティブに絞り込む |
| [swiper](https://github.com/abo-abo/swiper) | ivy ベースの検索。`C-s` で起動し、リアルタイムに候補を表示 |
| [counsel](https://github.com/abo-abo/swiper) | `M-x`・`find-file`・`switch-buffer` 等を ivy で強化 |
| [ivy-rich](https://github.com/Yevgnen/ivy-rich) | ivy の候補リストにファイルパス・ドキュメントを追加表示 |
| [amx](https://github.com/DarwinAwardWinner/amx) | `M-x` の使用頻度・履歴でソート。よく使うコマンドが上に来る |
| [which-key](https://github.com/justbur/emacs-which-key) | プレフィックスキー入力後、続くキーバインドの一覧をポップアップ表示 |
| [avy](https://github.com/abo-abo/avy) | 2文字入力で画面上の任意の位置へ一瞬でジャンプ |

### TypeScript

| パッケージ | 説明 |
|---|---|
| [typescript-mode](https://github.com/emacs-typescript/typescript.el) | `.ts` / `.tsx` 用メジャーモード。インデント幅 2 |
| [add-node-modules-path](https://github.com/codesuki/add-node-modules-path) | プロジェクトの `node_modules/.bin` を PATH に追加。ローカルの eslint 等を使用可能にする |
| [prettier-js](https://github.com/prettier/prettier-emacs) | TypeScript ファイル保存時に Prettier で自動フォーマット |

**事前インストール**
```sh
npm install -g typescript typescript-language-server
```

### コード補完 / LSP

| パッケージ | 説明 |
|---|---|
| [lsp-mode](https://github.com/emacs-lsp/lsp-mode) | LSP クライアント。対応ファイルを開くと自動起動。定義ジャンプ・補完・リネーム等。入力中の自動フォーマット・補完時の追加テキスト編集は無効化済み |
| [lsp-ui](https://github.com/emacs-lsp/lsp-ui) | lsp-mode の UI 強化。ドキュメントは画面下部に表示（入力の妨げにならないよう `at-point` から変更） |
| [company](https://github.com/company-mode/company-mode) | コード補完フレームワーク。**自動ポップアップは無効**。`C-M-i` で手動起動 |
| [company-box](https://github.com/sebastiencs/company-box) | company の補完候補をアイコン付きリッチUIで表示 |
| [company-quickhelp](https://github.com/company-quickhelp/company-quickhelp) | company 選択中の候補のドキュメントをツールチップで表示 |
| [yasnippet](https://github.com/joaotavora/yasnippet) | スニペット展開。`TAB` でテンプレートを展開 |

### シンタックスチェック

| パッケージ | 説明 |
|---|---|
| [flycheck](https://github.com/flycheck/flycheck) | リアルタイムのシンタックス・静的解析チェック。エラーをバッファ内に表示 |
| [flymake-posframe](https://github.com/lazycat-emacs/flymake-posframe) | flymake のエラーをカーソル付近のポップアップで表示 |

### 視覚的フィードバック

| パッケージ | 説明 |
|---|---|
| [rainbow-delimiters](https://github.com/Fanael/rainbow-delimiters) | 括弧をネストの深さに応じて色分け。対応関係が一目でわかる |
| [highlight-indent-guides](https://github.com/DarthFennec/highlight-indent-guides) | インデントレベルを縦線で可視化 |
| [volatile-highlights](https://github.com/k-talo/volatile-highlights.el) | undo・yank 直後に変更された範囲を一瞬ハイライト |
| [git-gutter](https://github.com/emacsorphanage/git-gutter) | 行番号の左側に Git の追加(+)・変更(~)・削除(-)を表示 |

### Git

| パッケージ | 説明 |
|---|---|
| [Magit](https://github.com/magit/magit) | Emacs 内で完結する Git UI。`C-c g` でステータス画面を開き、ステージ・コミット・push まで操作可能 |

### Org-mode

| パッケージ | 説明 |
|---|---|
| [org](https://orgmode.org/) | タスク管理・ドキュメント作成。TODO・スケジュール・アジェンダを管理 |
| [org-bullets](https://github.com/sabof/org-bullets) | 見出しの `*` を見やすい Unicode 記号に変換 |
| [org-capture](https://orgmode.org/manual/Capture.html) | `C-c c` でどこからでも即座にメモ・タスクを記録 |
| [org-pomodoro](https://github.com/marcinkoziej/org-pomodoro) | org のタスクに紐づいたポモドーロタイマー。アジェンダで `P` を押して開始 |

### プロジェクト管理

| パッケージ | 説明 |
|---|---|
| [projectile](https://github.com/bbatsov/projectile) | Git リポジトリをプロジェクトとして認識。プロジェクト内ファイル検索・切り替えが高速 |
| [counsel-projectile](https://github.com/ericdanan/counsel-projectile) | projectile の操作を ivy/counsel で強化 |

### ターミナル

| パッケージ | 説明 |
|---|---|
| [vterm](https://github.com/akermu/emacs-libvterm) | フル機能のターミナルエミュレータ。`C-c t` で起動。Claude Code 等の TUI アプリも動作する |

**事前インストール**
```sh
brew install cmake
```

### ユーティリティ

| パッケージ | 説明 |
|---|---|
| [exec-path-from-shell](https://github.com/purcell/exec-path-from-shell) | macOS で shell の PATH を Emacs に引き継ぐ。lsp-mode の言語サーバー検出に必要 |
| [smartparens](https://github.com/Fuco1/smartparens) | 括弧・クォートの自動補完。対応括弧のラップ・スワップ等も可能 |
| [undo-tree](https://github.com/apchamberlain/undo-tree.el) | undo 履歴をツリー構造で管理。`C-x u` で分岐した履歴を視覚的に操作 |
| [helpful](https://github.com/Wilfred/helpful) | ヘルプバッファをリッチに強化。ソースコードへのリンクや使用例も表示 |
