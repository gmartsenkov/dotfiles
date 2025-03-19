(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(setq package-selected-packages
      '(use-package
         diff-hl
         catppuccin-theme
         doom-modeline
         company
         yasnippet
         consult
         expand-region
         nerd-icons
         nerd-icons-completion
         rspec-mode
         vertico
         vertico-directory
         orderless
         marginalia
         flycheck
         evil
         evil-collection
         evil-surround
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
  (if (string-match "^finished" msg)
      (setq compilation-last-status "success")))

(setq compilation-last-status nil)
(setq compilation-finish-functions '(my/capture-last-compilation-status))

(use-package emacs
  :ensure nil
  :custom
  (custom-file (concat user-emacs-directory "custom.el"))
  (column-number-mode t)
  (auto-save-default nil)
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
    (and (bound-and-true-p compilation-in-progress)
         (propertize "[Compiling Gogo] " 'face (doom-modeline-face 'doom-modeline-compilation))))

  (doom-modeline-def-modeline 'my-simple-line
    '(bar matches buffer-info remote-host parrot)
    '(misc-info minor-modes input-method buffer-encoding custom-compile major-mode process vcs check))

  ;; Set default mode-line
  (add-hook 'doom-modeline-mode-hook
            (lambda ()
              (doom-modeline-set-modeline 'my-simple-line 'default))))

;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   (load-theme 'doom-ayu-dark t)
;;   (custom-set-faces `(vertical-border ((t (:background ,(doom-color 'bg))))))
;;   (custom-set-faces `(diff-indicator-removed ((t (:background unspecified :foreground ,(doom-darken (doom-color 'red) 0.3))))))
;;   (custom-set-faces `(diff-indicator-added ((t (:background unspecified :foreground ,(doom-darken (doom-color 'green) 0.3))))))
;;   (custom-set-faces `(diff-refine-added ((t (:inverse-video unspecified :foreground ,(doom-color 'fg) :background ,(doom-darken (doom-color 'green) 0.6))))))
;;   (custom-set-faces `(diff-refine-removed ((t (:inverse-video unspecified :foreground ,(doom-color 'fg) :background,(doom-darken (doom-color 'red) 0.6))))))
;;   (custom-set-faces `(diff-refine-changed ((t (:inverse-video unspecified :foreground ,(doom-color 'fg) :background ,(doom-darken (doom-color 'green) 0.6))))))
;;   (custom-set-faces `(diff-removed ((t (:foreground unspecified :background ,(doom-darken (doom-color 'red) 0.8))))))
;;   (custom-set-faces `(diff-added ((t (:foreground unspecified :background ,(doom-darken (doom-color 'green) 0.8))))))
;;   (custom-set-faces `(minibuffer-prompt ((t (:background unspecified :foreground ,(doom-color 'orange))))))
;;   (custom-set-faces `(lazy-highlight ((t (:background ,(doom-color 'base1))))))
;;   (custom-set-faces `(isearch ((t (:background ,(doom-color 'base2))))))
;;   (custom-set-faces `(yas-field-highlight-face ((t (:background unspecified :foreground ,(doom-color 'red))))))
;;   (custom-set-faces `(diff-hl-change ((t (:background unspecified :foreground ,(doom-color 'orange))))))
;;   (custom-set-faces `(diff-hl-delete ((t (:background unspecified :foreground ,(doom-color 'red))))))
;;   (custom-set-faces `(diff-hl-insert ((t (:background unspecified :foreground ,(doom-color 'green)))))))

(use-package catppuccin-theme
  :ensure t
  :config
  (load-theme 'catppuccin :no-confirm)
  (custom-set-faces `(vertical-border ((t (:background ,(catppuccin-get-color 'base))))))
  (custom-set-faces
   ;; Set the color for changes in the diff highlighting to blue.
   `(diff-hl-change ((t (:background unspecified :foreground ,(catppuccin-get-color 'blue))))))

  (custom-set-faces
   ;; Set the color for deletions in the diff highlighting to red.
   `(diff-hl-delete ((t (:background unspecified :foreground ,(catppuccin-get-color 'red))))))

  (custom-set-faces
   ;; Set the color for insertions in the diff highlighting to green.
   `(diff-hl-insert ((t (:background unspecified :foreground ,(catppuccin-get-color 'green)))))))

(use-package ace-window
  :ensure t
  :defer t
  :init
  (global-set-key (kbd "M-o") 'ace-window))

(use-package expand-region
  :ensure t
  :defer t
  :init
  (global-set-key (kbd "C-=") 'er/expand-region))
(use-package eldoc :ensure nil :init (global-eldoc-mode))
(use-package window
  :ensure nil
  :bind (("C-x C-f" . toggle-frame-fullscreen))
  :custom
  (display-buffer-alist
   '(((derived-mode . compilation-mode)
      (display-buffer-in-side-window)
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
  (rspec-key-command-prefix (kbd "C-c C-t"))
  (rspec-primary-source-dirs '("app" "apps" "lib")))

(use-package ruby-end :defer t :ensure t)

(use-package gleam-ts-mode
  :ensure t
  :commands gleam-ts-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.gleam$" . gleam-ts-mode))
  :bind (("C-c C-t a" . (lambda () (interactive) (my/run-command "gleam test")))))

(use-package eglot
  :ensure nil
  :init
  (add-hook 'ruby-mode-hook 'eglot-ensure)
  (add-hook 'typescript-ts-mode-hook 'eglot-ensure)
  (add-hook 'gleam-ts-mode-hook 'eglot-ensure)
  (setq-default eglot-events-buffer-size 0) ;; Disable logging
  (setq-default eglot-stay-out-of '(company flymake))
  (setq-default eglot-ignored-server-capabilities '(:inlayHintProvider))
  (setq-default eglot-inlay-hints-mode nil)
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

(use-package company
  :ensure t
  :custom
  (company-tooltip-align-annotations t)
  (company-minimum-prefix-length 2)
  (company-idle-delay 0.2)
  (company-tooltip-maximum-width 50)
  (company-backends '((company-yasnippet :separate company-capf company-dabbrev)))
  :config
  (define-key company-active-map (kbd "C-d") (lambda () (interactive) (company-show-doc-buffer)))
  (define-key company-active-map (kbd "C-j") 'company-select-next)
  (define-key company-active-map (kbd "C-k") 'company-select-previous)
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
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  :config
  (add-hook 'git-commit-mode-hook 'evil-insert-state))

(use-package xclip
  :ensure t
  :defer t
  :hook
  (after-init . xclip-mode))

(use-package evil
  :ensure t
  :defer t
  :hook
  (after-init . evil-mode)
  :init
  (setq evil-want-integration t)      ;; Integrate `evil' with other Emacs features (optional as it's true by default).
  (setq evil-want-keybinding nil)     ;; Disable default keybinding to set custom ones.
  :config
  (setq-default evil-symbol-word-search t)
  (defalias #'forward-evil-word #'forward-evil-symbol)
  ;; Set the leader key to space for easier access to custom commands. (setq evil-want-leader t)
  (setq evil-leader/in-all-states t)  ;; Make the leader key available in all states.
  (setq evil-want-fine-undo t)        ;; Evil uses finer grain undoing steps

  ;; Define the leader key as Space
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-set-leader 'visual (kbd "SPC"))

  (global-set-key (kbd "C-h") 'evil-window-left)
  (global-set-key (kbd "C-l") 'evil-window-right)
  (global-set-key (kbd "C-j") 'evil-window-down)
  (global-set-key (kbd "C-k") 'evil-window-up)
  (evil-define-key 'normal 'global (kbd "`") 'project-eshell)
  (evil-define-key 'insert eshell-mode-map (kbd "<escape>") (lambda () (interactive) (popper--bury-all)))
  (evil-define-key 'normal git-rebase-mode-map (kbd "C-j") 'git-rebase-move-line-down)
  (evil-define-key 'normal git-rebase-mode-map (kbd "C-k") 'git-rebase-move-line-up)
  (evil-define-key 'normal rspec-compilation-mode-map (kbd "C-j") 'compilation-next-error)
  (evil-define-key 'normal rspec-compilation-mode-map (kbd "C-k") 'compilation-previous-error)
  (evil-define-key 'normal compilation-mode-map (kbd "C-k") (lambda () (interactive) (select-window (previous-window))))
  (evil-define-key 'normal rspec-compilation-mode-map (kbd "C-k") (lambda () (interactive) (select-window (previous-window))))
  (evil-define-key 'normal 'global (kbd "<leader>x") 'consult-flycheck)
  (evil-define-key 'normal 'global (kbd "]d") 'flycheck-next-error)
  (evil-define-key 'normal 'global (kbd "[d") 'flycheck-previous-error)
  (evil-define-key 'normal 'global (kbd "]h") 'diff-hl-next-hunk)
  (evil-define-key 'normal 'global (kbd "[h") 'diff-hl-previous-hunk)
  (evil-define-key 'insert 'global (kbd "C-e") 'end-of-line)
  (evil-define-key 'insert 'global (kbd "C-a") 'beginning-of-line)
  (evil-define-key 'normal 'global (kbd "<leader>/") 'counsel-ripgrep)
  (evil-define-key 'normal 'global (kbd "<leader>hv") 'describe-variable)
  (evil-define-key 'normal 'global (kbd "<leader>hf") 'describe-function)
  (evil-define-key 'normal 'global (kbd "<leader>hk") 'describe-key)
  (evil-define-key 'normal 'global (kbd "<leader>bd") (lambda () (interactive) (kill-buffer (current-buffer))))
  (evil-define-key 'normal 'global (kbd "<leader>wv") 'split-window-right)
  (evil-define-key 'normal 'global (kbd "<leader>wh") 'split-window-below)
  (evil-define-key 'normal 'global (kbd "<leader>bb") 'consult-project-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>pp") 'project-switch-project)
  (evil-define-key 'normal 'global (kbd "<leader>SPC") 'project-find-file)
  (evil-define-key 'normal 'global (kbd "<leader>ff") 'find-file)
  (evil-define-key 'normal 'global (kbd "<leader>ca") 'eglot-code-actions)
  (evil-define-key 'normal 'global (kbd "<leader>gg") 'magit)
  (evil-define-key 'normal 'global (kbd "<leader>gb") 'magit-blame)
  (evil-define-key 'normal ruby-mode-map (kbd "<leader>tt") 'rspec-toggle-spec-and-target)
  (evil-define-key 'normal ruby-mode-map (kbd "<leader>tv") 'rspec-verify)
  (evil-define-key 'normal ruby-mode-map (kbd "<leader>tl") 'rspec-rerun)
  (evil-define-key 'normal ruby-mode-map (kbd "<leader>tf") 'rspec-run-last-failed)
  (evil-define-key 'normal ruby-mode-map (kbd "<leader>tc") 'rspec-verify-single)
  (evil-define-key 'normal ruby-mode-map (kbd "<leader>ta") 'rspec-verify-all)
  (evil-define-key 'normal ruby-mode-map (kbd "<leader>mp") (lambda () (interactive) (my/run-command "bundle exec rubocop")))
  (evil-define-key 'normal ruby-mode-map (kbd "<leader>mbi") (lambda () (interactive) (my/run-command "bundle install")))
  (evil-define-key 'normal rust-ts-mode-map (kbd "<leader>ta") 'rust-test)
  (evil-define-key 'normal rust-ts-mode-map (kbd "<leader>mr") 'rust-run)
  (evil-define-key 'normal rust-ts-mode-map (kbd "<leader>mb") 'rust-compile)
  (evil-define-key 'normal rust-ts-mode-map (kbd "<leader>mf") 'rust-format-buffer)
  (evil-define-key 'normal elixir-ts-mode-map (kbd "<leader>ta") '(lambda () (interactive) (my/run-command "mix test")))
  (evil-define-key 'normal elixir-ts-mode-map (kbd "<leader>tv") 'elixir-run-test)
  (evil-define-key 'normal elixir-ts-mode-map (kbd "<leader>tc") 'mix-test-current-test)
  (evil-define-key 'normal elixir-ts-mode-map (kbd "<leader>tt") 'gotospec)
  (evil-define-key 'normal elixir-ts-mode-map (kbd "<leader>mp") (lambda () (interactive) (my/run-command "mix credo")))
  (evil-define-key 'normal elixir-ts-mode-map (kbd "<leader>mf") (lambda () (interactive) (my/run-command "mix format")))
  (evil-define-key 'normal elixir-ts-mode-map (kbd "<leader>md") (lambda () (interactive) (my/run-command "mix deps.get")))
  (evil-define-key 'normal gleam-ts-mode-map (kbd "<leader>ta") (lambda () (interactive) (my/run-command "gleam test")))

  ;; Commenting functionality for single and multiple lines
  (evil-define-key 'normal 'global (kbd "gcc")
    (lambda ()
      (interactive)
      (if (not (use-region-p))
          (comment-or-uncomment-region (line-beginning-position) (line-end-position)))))

  (evil-define-key 'visual 'global (kbd "gc")
    (lambda ()
      (interactive)
      (if (use-region-p)
          (comment-or-uncomment-region (region-beginning) (region-end)))))
  (evil-mode 1))

(use-package evil-surround
  :ensure t
  :defer t
  :config
  (global-evil-surround-mode 1))

(use-package evil-collection
  :after evil
  :defer t
  :ensure t
  :hook
  (evil-mode . evil-collection-init)
  :config
  (evil-collection-init))

(use-package rainbow-delimiters
  :defer t
  :ensure t
  :hook
  (prog-mode . rainbow-delimiters-mode))
