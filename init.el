;;; init.el --- Emacs configuration

;;; ============================================================
;; パッケージ管理
;;; ============================================================

(require 'package)
(setq package-archives
      '(("melpa"  . "https://melpa.org/packages/")
        ("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/packages/")))
(package-initialize)

;; use-package がなければインストール
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)   ; 未インストールのパッケージを自動インストール
(setq use-package-always-defer nil)  ; 明示的に :defer しない限り即時ロード


;;; ============================================================
;; 基本設定
;;; ============================================================

;; C-h をバックスペースに変更
(global-set-key (kbd "C-h") 'delete-backward-char)

;; UI の余計な要素を非表示
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)   (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; スタートアップ画面を非表示
(setq inhibit-startup-message t)

;; 行番号を表示
(global-display-line-numbers-mode t)

;; 対応する括弧をハイライト (組込)
(show-paren-mode t)
(setq show-paren-delay 0)

;; タブをスペースに変換
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; バックアップファイルを作らない
(setq make-backup-files nil)
(setq auto-save-default nil)

;; macOS の PATH を引き継ぐ
(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))


;;; ============================================================
;; UI / テーマ
;;; ============================================================

;; アイコンフォント (初回は M-x nerd-icons-install-fonts を実行)
(use-package nerd-icons)

;; テーマ: doom-dracula
(use-package doom-themes
  :config
  (load-theme 'doom-dracula t)
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (doom-themes-org-config))

;; モードライン
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-height 28)
  (doom-modeline-bar-width 4)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon t)
  (doom-modeline-buffer-file-name-style 'truncate-upto-project))

;; 特定バッファでモードラインを非表示
(use-package hide-mode-line
  :hook
  ((neotree-mode imenu-list-minor-mode minimap-mode) . hide-mode-line-mode))

;; ダッシュボード
(use-package dashboard
  :custom
  (dashboard-startup-banner 'logo)
  (dashboard-center-content t)
  (dashboard-items '((recents   . 8)
                     (projects  . 5)
                     (bookmarks . 5)))
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t)
  :config
  (dashboard-setup-startup-hook))

;; ミニマップ
(use-package minimap
  :custom
  (minimap-window-location 'right)
  (minimap-update-delay 0.2)
  (minimap-minimum-width 15))

;; スクロール時にカーソルをフラッシュ
(use-package beacon
  :config
  (beacon-mode t)
  :custom
  (beacon-color "#f8f8f2"))


;;; ============================================================
;; ファイルツリー / 構造ナビゲーション
;;; ============================================================

;; ファイルツリー
(use-package neotree
  :bind ("C-c n" . neotree-toggle)
  :custom
  (neo-theme (if (display-graphic-p) 'nerd-icons 'arrow))
  (neo-smart-open t)
  (neo-window-width 30))

;; 関数・見出し一覧サイドバー
(use-package imenu-list
  :bind ("C-c i" . imenu-list-smart-toggle)
  :custom
  (imenu-list-focus-after-activation t)
  (imenu-list-auto-resize t))


;;; ============================================================
;; 補完 / ナビゲーション (ivy エコシステム)
;;; ============================================================

(use-package ivy
  :config
  (ivy-mode t)
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-count-format "(%d/%d) ")
  (ivy-height 15))

(use-package swiper
  :bind ("C-s" . swiper))

(use-package counsel
  :config
  (counsel-mode t)
  :bind
  ("M-x"     . counsel-M-x)
  ("C-x C-f" . counsel-find-file)
  ("C-x b"   . counsel-switch-buffer))

(use-package ivy-rich
  :after (ivy counsel)
  :config
  (ivy-rich-mode t)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))

;; M-x の履歴・頻度ソート
(use-package amx
  :after counsel
  :config
  (amx-mode t))

;; キーバインドヘルプ
(use-package which-key
  :config
  (which-key-mode t)
  :custom
  (which-key-idle-delay 0.5))

;; キーワードジャンプ
(use-package avy
  :bind
  ("C-;" . avy-goto-char-2)
  ("M-g g" . avy-goto-line))


;;; ============================================================
;; コード補完
;;; ============================================================

(use-package company
  :hook (after-init . global-company-mode)
  :custom
  (company-idle-delay nil)             ; 自動ポップアップを無効化（手動起動のみ）
  (company-minimum-prefix-length 2)    ; 手動起動時に2文字以上で候補表示
  (company-tooltip-align-annotations t)
  (company-auto-commit nil)            ; IME 確定時に補完候補を誤挿入しない
  (company-dabbrev-downcase nil)       ; 大文字小文字を保持
  (company-dabbrev-ignore-case t))

;; リッチな補完ポップアップ
(use-package company-box
  :hook (company-mode . company-box-mode)
  :custom
  (company-box-icons-alist 'company-box-icons-nerd-icons))

;; 補完候補のドキュメントツールチップ
(use-package company-quickhelp
  :hook (company-mode . company-quickhelp-mode)
  :custom
  (company-quickhelp-delay 0.5))

;; スニペット (lsp-mode のスニペット補完に必要)
(use-package yasnippet
  :config
  (yas-global-mode t))

(use-package yasnippet-snippets
  :after yasnippet)


;;; ============================================================
;; TypeScript
;;; ============================================================

(use-package typescript-mode
  :mode "\\.tsx?\\'"
  :custom
  (typescript-indent-level 2))

(use-package add-node-modules-path
  :hook (typescript-mode . add-node-modules-path))

(use-package prettier-js
  :hook (typescript-mode . prettier-js-mode))


;;; ============================================================
;; LSP (Language Server Protocol)
;;; ============================================================

(use-package lsp-mode
  :hook
  ((python-mode
    js-mode
    typescript-mode
    rust-mode
    go-mode
    c-mode
    c++-mode) . lsp-deferred)
  :custom
  (lsp-idle-delay 0.3)
  (lsp-log-io nil)
  (lsp-keymap-prefix "C-c l")
  (lsp-enable-on-type-formatting nil)           ; 入力中の自動フォーマットを無効化
  (lsp-completion-enable-additional-text-edit nil) ; 補完時の追加テキスト編集を無効化
  :commands lsp)

(use-package lsp-ui
  :after lsp-mode
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'bottom)        ; at-point は入力の邪魔になるため変更
  (lsp-ui-doc-delay 1.0)
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-peek-always-show t))

;; lsp と ivy を統合
(use-package lsp-ivy
  :after (lsp-mode ivy)
  :commands lsp-ivy-workspace-symbol)


;;; ============================================================
;; シンタックスチェック
;;; ============================================================

(use-package flycheck
  :hook (after-init . global-flycheck-mode))

;; flymake-posframe は MELPA 未掲載のため無効化


;;; ============================================================
;; 視覚的フィードバック
;;; ============================================================

;; 括弧をネストレベルごとに色分け
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; インデントガイド
(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-method 'character))

;; 変更箇所をフラッシュ
(use-package volatile-highlights
  :config
  (volatile-highlights-mode t))

;; Git 差分をガターに表示
(use-package git-gutter
  :hook (after-init . global-git-gutter-mode)
  :custom
  (git-gutter:update-interval 1))


;;; ============================================================
;; Git
;;; ============================================================

(use-package magit
  :bind ("C-c g" . magit-status))


;;; ============================================================
;; プロジェクト管理
;;; ============================================================

(use-package projectile
  :config
  (projectile-mode t)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :custom
  (projectile-completion-system 'ivy))

(use-package counsel-projectile
  :after (counsel projectile)
  :config
  (counsel-projectile-mode t))


;;; ============================================================
;; Org-mode
;;; ============================================================

(use-package org
  :custom
  (org-directory "~/org")
  (org-default-notes-file "~/org/inbox.org")
  (org-hide-leading-stars t)
  (org-startup-indented t)
  (org-todo-keywords
   '((sequence "TODO(t)" "IN-PROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
  :bind
  ("C-c a" . org-agenda)
  ("C-c c" . org-capture))

;; 見出し記号を Unicode 文字に
(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "◆" "◇")))

;; ポモドーロタイマー
(use-package org-pomodoro
  :after org
  :bind (:map org-agenda-mode-map
              ("P" . org-pomodoro)))


;;; ============================================================
;; ターミナル
;;; ============================================================

(use-package vterm
  :bind ("C-c t" . vterm)
  :custom
  (vterm-max-scrollback 10000))


;;; ============================================================
;; ユーティリティ
;;; ============================================================

;; 括弧の自動補完・操作
(use-package smartparens
  :hook (prog-mode . smartparens-mode)
  :config
  (require 'smartparens-config))

;; undo 履歴をツリーで管理
(use-package undo-tree
  :config
  (global-undo-tree-mode t)
  :custom
  (undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo-tree"))))

;; ヘルプバッファを強化
;; C-h はバックスペースに使用しているため C-c h プレフィックスに割り当て
(use-package helpful
  :bind
  ("C-c h f" . helpful-callable)
  ("C-c h v" . helpful-variable)
  ("C-c h k" . helpful-key)
  ("C-c h x" . helpful-command))

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-insertion-on-trigger nil nil nil "Customized with use-package company")
 '(package-selected-packages
   '(add-node-modules-path amx avy beacon company-box company-quickhelp
                           counsel-projectile dashboard doom-modeline
                           doom-themes exec-path-from-shell flycheck
                           git-gutter helpful hide-mode-line
                           highlight-indent-guides imenu-list ivy-rich
                           lsp-ivy lsp-ui magit minimap neotree
                           org-bullets org-pomodoro prettier-js
                           rainbow-delimiters smartparens
                           typescript-mode undo-tree
                           volatile-highlights vterm-toggle
                           yasnippet-snippets)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
