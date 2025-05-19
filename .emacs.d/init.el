(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

; (seq-do
;  (lambda (buffer) (message (buffer-name buffer))
;    (buffer-list))
;
; (buffer-name (current-buffer))
(setq package-selected-packages
      '(use-package
         diff-hl
         catppuccin-theme
         doom-modeline
         surround
         multiple-cursors
         expand-region
         company
         yasnippet
         yasnippet-capf
         consult
         nerd-icons
         nerd-icons-completion
         rspec-mode
         vertico
         vertico-directory
         orderless
         marginalia
         flycheck
         rainbow-delimiters
         ace-window
         flycheck-eglot
         ruby-end
         magit
         gleam-ts-mode
         treesit-auto
         reformatter))

(setq package-vc-selected-packages
      '((eglot-booster :url "https://github.com/jdtsmith/eglot-booster" :branch "main")
        (flycheck-overlay :url "https://github.com/konrad1977/flycheck-overlay" :rev "acf6cc9b8b80041a2a1665775566cefcdfd306ee")))

(defun my/run-command (cmd)
  (let ((default-directory (car (last (project-current)))))
    (compile cmd)))

(defun code/relative-buffer-name ()
  (rename-buffer
   (file-relative-name buffer-file-name (car (last (project-current))))))

(require 'ansi-color)
(defun my/ansi-colorize-buffer ()
  (let ((buffer-read-only nil))
    (ansi-color-apply-on-region (point-min) (point-max))))

(add-hook 'compilation-filter-hook 'my/ansi-colorize-buffer)

(defun my/capture-last-compilation-status (buf msg)
  (if (string-match "^exited abnormally with code 1" msg)
      (setq compilation-last-failed 1)
    (setq compilation-last-failed 0)))

(setq compilation-last-failed nil)
(setq compilation-finish-functions '(my/capture-last-compilation-status))

(use-package emacs
  :ensure nil
  :bind
  (("C-c g" . avy-goto-char-2)
   ("C-x C-f" . find-file))
  :custom
  (custom-file (concat user-emacs-directory "custom.el"))
  (column-number-mode t)
  (auto-save-default nil)
  (tab-always-indent 'complete)
  (text-mode-ispell-word-completion nil)
  (create-lockfiles nil)
  (delete-by-moving-to-trash t)
  (delete-selection-mode 1)
  (global-auto-revert-non-file-buffers t)
  (history-length 25)
  (inhibit-startup-message t)
  (initial-scratch-message "")
  (make-backup-files nil)
  (pixel-scroll-precision-mode t)
  (pixel-scroll-precision-use-momentum nil)
  (ring-bell-function 'ignore)
  (split-width-threshold 300)
  (switch-to-buffer-obey-display-actions t)
  (css-indent-offset 2)
  (js-indent-level 2)
  (indent-tabs-mode nil)
  (treesit-font-lock-level 4)
  (truncate-lines t)
  (use-dialog-box nil)
  (use-short-answers t)
  (global-visual-line-mode t)
  (electric-pair-mode t)
  (compilation-scroll-output t)
  (compilation-always-kill t)
  (compilation-scroll-output t)
  (scroll-conservatively most-positive-fixnum)
  (scroll-margin 20)
  (project-switch-commands 'project-find-file)
  (warning-minimum-level :emergency)

  :hook
  (conf-unix-mode . display-line-numbers-mode)
  (prog-mode . display-line-numbers-mode)
  (markdown-mode . display-line-numbers-mode)
  (before-save . delete-trailing-whitespace)
  (find-file-hook . code/relative-buffer-name)

  :init
  (load (concat user-emacs-directory "custom.el") :noerror)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)

  (global-hl-line-mode 1)
  (global-auto-revert-mode 1)
  (indent-tabs-mode -1)
  (recentf-mode 1)
  (savehist-mode 1)
  (save-place-mode 1)
  (winner-mode)
  (xterm-mouse-mode 1)
  (file-name-shadow-mode 1)

  ;; Add a hook to run code after Emacs has fully initialized.
  (add-hook 'after-init-hook
            (lambda ()
              (message "Emacs has fully loaded. This code runs after startup.")

              ;; Insert a welcome message in the *scratch* buffer displaying loading time and activated packages.
              (with-current-buffer (get-buffer-create "*scratch*")
                (insert (format
                         ";;    Welcome to Emacs!
;;
;;    Loading time : %s
;;    Packages     : %s
"
                         (emacs-init-time)
                         (number-to-string (length package-activated-list))))))))

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-langs '(typescript javascript rust))
  :config
  (add-to-list 'auto-mode-alist '("\\.ex\\'" . elixir-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.exs\\'" . elixir-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.gleam\\'" . gleam-ts-mode))
  (global-treesit-auto-mode))

(use-package doom-modeline
  :ensure t
  :defer t
  :custom
  (doom-modeline-buffer-file-name-style 'buffer-name)
  (doom-modeline-project-detection 'project)
  (doom-modeline-buffer-name t)
  (doom-modeline-vcs-max-length 25)
  (doom-modeline-icon t)
  (doom-modeline-buffer-encoding nil)
  :hook
  (after-init . doom-modeline-mode)
  :config
  (doom-modeline-def-segment custom-compile
    (if (bound-and-true-p compilation-in-progress)
        (propertize "[Compiling] " 'face (doom-modeline-face 'doom-modeline-compilation))
      (cond ((eq compilation-last-failed 1) (propertize "[Failed] " 'face (doom-modeline-face 'doom-modeline-lsp-error)))
            ((eq compilation-last-failed 0) (propertize "[Success] " 'face (doom-modeline-face 'doom-modeline-lsp-success))))))

  (doom-modeline-def-modeline 'my-simple-line
    '(bar matches buffer-info remote-host parrot)
    '(misc-info minor-modes input-method buffer-encoding custom-compile major-mode process vcs check))

  ;; Set default mode-line
  ;; (add-hook 'doom-modeline-mode-hook  (lambda () (doom-modeline-set-modeline 'my-simple-line 'default)))
  )

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-ir-black t)
  (custom-set-faces '(default ((t (:background "nil"))))))

(use-package ace-window
  :ensure t
  :defer t
  :bind (("M-o" . ace-window)))

(use-package eldoc :ensure nil :init (global-eldoc-mode))
(use-package window
  :ensure nil
  :custom
  (display-buffer-alist
   '(((derived-mode . compilation-mode)
      (display-buffer-in-side-window)
      (window-preserve-size . t)
      (window-width . 0.35)
      (side . right)
      (slot . 0))
     ("magit:"
      (display-buffer-in-side-window)
      (body-function . select-window)
      (window-preserve-size . t)
      (window-width . 0.35)
      (side . right)
      (slot . 0))
     ("\\*vc-git"
      (display-buffer-in-side-window)
      (side . bottom)
      (window-height . 10)
      (slot . 1))
     ("\\*vc-diff\\*"
      (display-buffer-in-side-window)
      (body-function . select-window)
      (window-width . 0.35)
      (side . right)
      (slot . 0))
     ((derived-mode . eldoc-mode)
      (display-buffer-reuse-mode-window
       display-buffer-below-selected)
      (window-height . 0.3)
      (slot . 2))
     ((derived-mode . help-mode)
      (display-buffer-in-side-window)
      (window-width . 0.35)
      (side . right)
      (slot . 0)))))

(use-package inf-ruby
  :ensure t
  :defer t
  :config
  (inf-ruby-enable-auto-breakpoint))

(use-package ruby-mode
  :ensure nil
  :custom
  (ruby-indent-level 2)
  (ruby-insert-encoding-magic-comment nil)
  (ruby-method-call-indent nil)
  (ruby-after-operator-indent nil)
  (ruby-parenless-call-arguments-indent nil)
  (ruby-method-params-indent 0)
  (ruby-block-indent nil)
  (ruby-align-chained-calls nil)
  (ruby-deep-indent-paren nil)
  :init
  (add-hook 'ruby-mode-hook (lambda () (setq flycheck-eglot-exclusive nil))))

(use-package rspec-mode
  :ensure t
  :defer t
  :custom
  (rspec-key-command-prefix (kbd "C-c ,"))
  (rspec-primary-source-dirs '("app" "apps" "lib")))

(use-package ruby-end :defer t :ensure t)

(use-package gleam-ts-mode
  :ensure t
  :commands gleam-ts-mode
  :bind
  (("C-c , a" . (lambda () (interactive) (my/run-command "gleam test"))))
  :init
  (add-to-list 'auto-mode-alist '("\\.gleam$" . gleam-ts-mode))
  :bind (("C-c C-t a" . (lambda () (interactive) (my/run-command "gleam test")))))

(use-package eglot
  :ensure nil
  :init
;  (add-hook 'ruby-mode-hook 'eglot-ensure)
  (add-hook 'typescript-ts-mode-hook 'eglot-ensure)
  (add-hook 'gleam-ts-mode-hook 'eglot-ensure)
  (setq-default eglot-events-buffer-size 0) ;; Disable logging
  (setq-default eglot-stay-out-of '(company flymake))
  (setq-default eglot-ignored-server-capabilities '(:inlayHintProvider))
  (setq-default eglot-inlay-hints-mode nil)
  (setq-default eglot-code-action-indicator nil)
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 '(gleam-ts-mode . ("gleam" "lsp")))
    (add-to-list 'eglot-server-programs
                 `((elixir-ts-mode heex-ts-mode elixir-mode) .
                   ("elixir-ls" "--stdio=true" :initializationOptions (:experimental (:completions (:enable t))))))))

(use-package eglot-booster
  :ensure t
  :defer t
  :vc (:url "https://github.com/jdtsmith/eglot-booster" :branch "main")
  :after eglot
  :config (eglot-booster-mode))

(use-package flycheck
  :ensure t
  :defer t
  :custom
  (flycheck-highlighting-mode nil)
  (flycheck-indication-mode nil)
  (flycheck-keymap-prefix (kbd "C-c C-f"))
  :hook ((ruby-mode typescript-ts-mode gleam-ts-mode) . flycheck-mode))

(use-package flycheck-eglot
  :ensure t
  :after (flycheck eglot)
  :config
  (global-flycheck-eglot-mode 1))

(use-package flycheck-overlay
  :vc (:url "https://github.com/konrad1977/flycheck-overlay" :rev "acf6cc9b8b80041a2a1665775566cefcdfd306ee")
  :ensure t
  :defer t
  :custom
  (flycheck-overlay-hide-checker-name t)
  (flycheck-overlay-show-at-eol nil)
  (flycheck-overlay-show-virtual-line t)
  (flycheck-overlay-virtual-line-type 'line-no-arrow)
  (flycheck-overlay-icon-left-padding 1.2)
  :init
  (add-hook 'flycheck-mode-hook #'flycheck-overlay-mode))

(use-package reformatter
  :ensure t
  :defer t
  :hook (clojure-mode . cljstyle-format-on-save-mode)
  :hook (gleam-ts-mode . gleam-format-on-save-mode)
  :config
  (reformatter-define cljstyle-format
    :program "cljstyle"
    :args '("pipe")
    :lighter " CLJ")
  (reformatter-define gleam-format
    :program "gleam"
    :args '("format" "--stdin")
    :lighter " GLEAM"))

(use-package consult
  :ensure t
  :defer t
  :custom
  (consult-preview-key nil)
  :bind (("C-c i" . consult-imenu)
         ("C-c l" . consult-line))
  :init
  ;; Enhance register preview with thin lines and no mode line.
  (setq xref-show-xrefs-function #'consult-xref xref-show-definitions-function #'consult-xref)
  (advice-add #'register-preview :override #'consult-register-window))

(use-package vertico
  :ensure t
  :defer t
  :hook
  (after-init . vertico-mode)
  :custom
  (vertico-count 15)
  (vertico-resize nil)
  (vertico-cycle nil)
  (completion-styles '(basic partial-completion orderless))
  :bind (:map vertico-map
	      ("C-j" . vertico-next)
	      ("C-k" . vertico-previous)
	      ("C-f" . vertico-exit)
	      :map minibuffer-local-map
	      ("M-h" . backward-kill-word)))

(use-package vertico-directory
  :ensure nil
  :defer t
  :after vertico
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package orderless
  :ensure t
  :defer t
  :after vertico
  :init
  (setq completion-styles '(orderless basic)
        completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
  :ensure t
  :hook
  (after-init . marginalia-mode))

(use-package nerd-icons :ensure t :defer t)

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package surround
  :ensure t
  :bind-keymap ("M-'" . surround-keymap))

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

(use-package company
  :ensure t
  :custom
  (company-tooltip-align-annotations t)
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.2)
  (company-tooltip-maximum-width 50)
  (company-backends '((company-yasnippet :separate company-capf company-dabbrev)))
  :config
  (define-key company-active-map [tab] 'company-complete-selection)
  (define-key company-active-map (kbd "TAB") 'company-complete-selection)
  (define-key company-active-map [ret] 'company-complete-selection)
  (define-key company-active-map (kbd "RET") 'company-complete-selection)
  :hook
  (prog-mode . company-mode)
  (markdown-mode . company-mode))

(use-package yasnippet :ensure t :defer t :init (yas-global-mode 1))

(use-package diff-hl
  :defer t
  :ensure t
  :hook
  (find-file . (lambda ()
                 (global-diff-hl-mode)
                 (diff-hl-flydiff-mode)
                 (diff-hl-margin-mode)))
  :custom
  (diff-hl-side 'left)
  (diff-hl-margin-symbols-alist '((insert . "│")
                                  (delete . "-")
                                  (change . "│")
                                  (unknown . "?")
                                  (ignored . "i"))))

(use-package vc
  :ensure nil
  :bind (("C-x v p" . vc-pull)))

(use-package magit
  :ensure t
  :defer t
  :after (nerd-icons)
  :init
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(use-package xclip
  :ensure t
  :defer t
  :hook
  (after-init . xclip-mode))

(use-package rainbow-delimiters
  :defer t
  :ensure t
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package multiple-cursors
  :ensure t
  :bind (("C-M-." . mc/mark-next-like-this)
         ("C-M-," . mc/mark-previous-like-this)
         ("C-M-/" . mc/mark-all-like-this)))

(use-package tab-bar
  :ensure nil
  :custom-face
  (tab-bar ((t (:inherit mode-line))))
  (tab-bar-tab ((t (:inherit mode-line :foreground "white"))))
  (tab-bar-tab-inactive ((t (:inherit mode-line-inactive :foreground "black"))))
  :custom
  (tab-bar-show 1)
  (tab-bar-close-button-show nil)
  (tab-bar-format '(tab-bar-format-tabs tab-bar-separator))
  :bind (("C-c w n" . tab-bar-new-tab)
         ("C-c w s" . tab-bar-switch-to-tab)
         ("C-c w x" . tab-bar-close-tab)
         ("C-c w ]" . tab-next)
         ("C-c w [" . tab-previous))
  :config
  (tab-bar-mode 1))

(use-package eat
  :ensure t
  :config
  (add-hook 'eshell-load-hook #'eat-eshell-mode))

(use-package indent-bars
  :ensure t
  :custom
  (indent-bars-color-by-depth nil)
  (indent-bars-color '(shadow))
  :config
  (add-hook 'prog-mode-hook 'indent-bars-mode))
