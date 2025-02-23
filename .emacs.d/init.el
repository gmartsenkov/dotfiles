(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(setq package-selected-packages
      '(use-package
         diff-hl
         doom-themes
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
         meow
         ace-window
         flycheck-eglot
         ruby-end
         magit
         gleam-ts-mode
         reformatter))

(setq package-vc-selected-packages
      '((eglot-booster :url "https://github.com/jdtsmith/eglot-booster" :branch "main")
        (flycheck-overlay :url "https://github.com/konrad1977/flycheck-overlay" :rev "acf6cc9b8b80041a2a1665775566cefcdfd306ee")))


(defun code/relative-buffer-name ()
  (rename-buffer
   (file-relative-name buffer-file-name (car (last (project-current))))))

(setq-default mode-line-format
  '(:eval
    (let ((prefix (cond (buffer-read-only     '("RO" . nano-default-i))
                        ((buffer-modified-p)  '("**" . nano-critical-i))
                        (t                    '("RW" . nano-faded-i))))
          (mode (concat "(" (downcase (cond ((consp mode-name) (car mode-name))
                                            ((stringp mode-name) mode-name)
                                            (t "unknow")))
                        " mode)"))
          (eglot-server (eglot-current-server))
          (coords (format-mode-line "%c:%l ")))
      (list
       (propertize " " 'face (cdr prefix)  'display '(raise -0.25))
       (propertize (car prefix) 'face (cdr prefix))
       (propertize " " 'face (cdr prefix) 'display '(raise +0.25))
       (propertize (format-mode-line " %b ") 'face 'nano-strong)
       (if eglot-server (propertize (concat " [eglot:" (eglot-project-nickname eglot-server) "]")))
       (propertize " " 'display `(space :align-to (- right ,(length coords))))
       (propertize coords 'face 'nano-faded)))))

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
  (load custom-file :noerror)
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

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-tokyo-night t)
  (custom-set-faces
   `(diff-hl-change ((t (:background unspecified :foreground ,(doom-color 'orange))))))
  (custom-set-faces
   `(diff-hl-delete ((t (:background unspecified :foreground ,(doom-color 'red))))))
  (custom-set-faces
   `(diff-hl-insert ((t (:background unspecified :foreground ,(doom-color 'green))))))
  )

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
   '(("\\*rspec-compilation\\*"
      (display-buffer-in-side-window)
      (window-width . (if (frame-width < 160) 0.5 0.35))
      (side . right)
      (slot . 0))
     ("magit:"
      (display-buffer-in-side-window)
      (body-function . select-window)
      (window-preserve-size . t)
      (window-width . (if (frame-width < 160) 0.5 0.35))
      (side . right)
      (slot . 0))
     ("\\*vc-diff\\*"
      (display-buffer-in-side-window)
      (body-function . select-window)
      (window-width . (if (frame-width < 160) 0.5 0.35))
      (side . right)
      (slot . 0))
     ("\\*Help\\*"
      (display-buffer-in-side-window)
      (window-width . 0.35)
      (side . right)
      (slot . 0)))))

(use-package ruby
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
  (rspec-primary-source-dirs '("app" "apps" "lib")))

(use-package ruby-end :defer t :ensure t)

(use-package gleam-ts-mode :mode (rx ".gleam" eos))

(use-package eglot
  :ensure nil
  :init
  (add-hook 'ruby-mode-hook 'eglot-ensure)
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
  :hook ((ruby-mode gleam-ts-mode) . flycheck-mode))

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

(use-package magit
  :ensure t
  :defer t
  :after (nerd-icons)
  :config
  (add-hook 'git-commit-mode-hook 'meow-insert)
  :init
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(defun meow-setup ()
  (setq meow-expand-hint-counts '())
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   '("v" . "C-x v")
   '("t" . "C-x M-t")
   '("SPC" . project-find-file)
   '("b" . project-switch-to-buffer)
   '("pp" . project-switch-project)
   '("mp" . flycheck-compile)
   '("f" . find-file)
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . consult-grep)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("q" . (lambda () (interactive) (popper--bury-all)))
   '("}" . forward-paragraph)
   '("{" . backward-paragraph)
   '(">" . indent-rigidly-right)
   '("<" . indent-rigidly-left)
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("o" . meow-open-below)
   '("O" . meow-open-above)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("p" . meow-yank)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("/" . consult-line)
   '("=" . er/expand-region)))

(use-package meow
  :ensure t
  :custom
  (meow-use-clipboard t)
  :config
  (meow-setup)
  (meow-global-mode 1))
