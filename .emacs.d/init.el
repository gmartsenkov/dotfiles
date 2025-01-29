;;; init.el --- Emacs-Kick --- A feature rich Emacs config for (neo)vi(m)mers -*- lexical-binding: t; -*-
;; Author: Rahul Martim Juliato
;; Version: 0.1.0
;; Package-Requires: ((emacs "30.0"))
;; License: GPL-2.0-or-later

;;; Commentary:
;; =====================================================================
;; ==================== READ THIS BEFORE CONTINUING ====================
;; =====================================================================
;; ========                                    .-----.          ========
;; ========         .----------------------.   | === |          ========
;; ========         |.-""""""""""""""""""-.|   |-----|          ========
;; ========         ||                    ||   | === |          ========
;; ========         ||     EMACS-KICK     ||   |-----|          ========
;; ========         ||                    ||   | === |          ========
;; ========         ||                    ||   |-----|          ========
;; ========         ||M-x                 ||   |:::::|          ========
;; ========         |'-..................-'|   |____o|          ========
;; ========         `"")----------------(""`   ___________      ========
;; ========        /::::::::::|  |::::::::::\  \ no mouse \     ========
;; ========       /:::========|  |==hjkl==:::\  \ required \    ========
;; ========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
;; ========                                                     ========
;; =====================================================================
;; =====================================================================

;; What is Emacs-Kick?
;;
;; Emacs-Kick is `not' a distribution.
;;
;; Emacs-Kick is a starting point for your own configuration.  The goal
;; is that you can read every line of code, top-to-bottom, understand
;; what your configuration is doing, and modify it to suit your needs.
;;
;; Once you've done that, you can start exploring, configuring, and
;; tinkering to make Emacs your own! That might mean leaving Emacs
;; Kick just the way it is for a while or immediately breaking it into
;; modular pieces.  It's up to you!
;;
;; If you don't know anything about Emacs Lisp, I recommend taking
;; some time to read through a guide.
;; One possible example which will only take 10-15 minutes:
;; - https://learnxinyminutes.com/docs/elisp/
;;
;; After understanding a bit more about Emacs Lisp, you can use `M-x
;; info RET` (info) for a reference on how Emacs integrates it.
;;
;; Emacs-Kick Guide:
;;
;; Well, this config ASSUMES you already knows (neo)vi(m) bindings,
;; and the bases of how it works.  This is the `Emacs config for
;; vimmers'.  So, if you're not familiar with it, go for
;; `kickstart.nvim', get used to it, and than come back.
;;
;; On Emacs help can be found multiple ways.
;; With this config, the leader key as SPC.
;; - <leader> h i opens the info (Also `M-x info RET')
;; - <leader> h v explores available variables
;; - <leader> h f explores avaliable functions
;; - <leader> h k explores avaliable keybindings
;;
;; If, at any time you need to find some functionality, Emacs `M-x'
;; (Meta is alt on most cases, option or command), works like a
;; command pallete, you can for example type `M-x quit' and be
;; presented with various options to quit Emacs.
;;
;; Once you've completed that, you can continue working through
;; `AND READING' the rest of the kickstart configuration.
;;
;; I have left several comments throughout the configuration.  These
;; are hints about where to find more information about the relevant
;; settings, packages, or Emacs features used in Emacs-Kick.
;;
;; Feel free to delete them once you know what you're doing, but they
;; should serve as a guide for when you are first encountering a few
;; different constructs in your Emacs config.
;;
;; If you encounter any errors while installing Emacs-Kick,
;; check the *Messages* buffer for more information. You can switch
;; buffers using `<leader> SPC`, and all option menus can be navigated
;; with `C-p` and `C-n`.
;;
;; I hope you enjoy your Emacs journey,
;; - Rahul
;;
;; P.S.  You can delete this when you're done too.  It's your config
;; now! :)


;;; Code:

;; Performance Hacks
;; Emacs is an Elisp interpreter, and when running programs or packages,
;; it can occasionally experience pauses due to garbage collection.
;; By increasing the garbage collection threshold, we reduce these pauses
;; during heavy operations, leading to smoother performance.
(setq gc-cons-threshold #x40000000)

;; Set the maximum output size for reading process output, allowing for larger data transfers.
(setq read-process-output-max (* 1024 1024 4))

;; Do I really need a speedy startup?
;; Well, this config launches Emacs in about ~0.3 seconds,
;; which, in modern terms, is a miracle considering how fast it starts
;; with external packages.
;; It wasn’t until the recent introduction of tools for lazy loading
;; that a startup time of less than 20 seconds was even possible.
;; Other fast startup methods were introduced over time.
;; You may have heard of people running Emacs as a server,
;; where you start it once and open multiple clients instantly connected to that server.
;; Some even run Emacs as a systemd or sysV service, starting when the machine boots.
;; While this is a great way of using Emacs, we WON’T be doing that here.
;; I think 0.3 seconds is fast enough to avoid issues that could arise from
;; running Emacs as a server, such as 'What version of Node is my LSP using?'.
;; Again, this setup configures Emacs much like how a Vimmer would configure Neovim.

;; Emacs already comes with its on package manager.
;; Others are available, but let's stick with the defaults when it makes sense.
;;
;; Requires the Emacs default package manager, so we can set it. Kind of an 'import'.
(require 'package)
;; Add MELPA (Milkypostman's Emacs Lisp Package Archive) to the list of package archives.
;; This allows you to install packages from this widely-used repository, similar to how
;; pip works for Python or npm for Node.js. While Emacs comes with ELPA (Emacs Lisp
;; Package Archive) configured by default, which contains packages that meet specific
;; licensing criteria, MELPA offers a broader range of packages and is considered the
;; standard for Emacs users. You can also add more package archives later as needed.
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Initialize the package system. In Emacs, a package is a collection of Elisp code
;; that extends the functionality of the editor, similar to plugins in Neovim.
;; By calling `package-initialize', we load the list of available packages from
;; the configured archives (like MELPA) and make them ready for installation and use.
;; This process is akin to using lazy.nvim or packer.nvim in Neovim, which manage
;; plugin installations and configurations. While there are third-party package managers
;; available for Emacs, such as straight.el and use-package, we are sticking with
;; the default package manager for simplicity in this configuration.
(package-initialize)


;; Define a global customizable variable `ek-use-nerd-fonts' to control the use of
;; Nerd Fonts symbols throughout the configuration. This boolean variable allows
;; users to easily enable or disable the use of symbols from Nerd Fonts, providing
;; flexibility in appearance settings. By setting it to `t', we enable Nerd Fonts
;; symbols; setting it to `nil' would disable them.
(defcustom ek-use-nerd-fonts t
  "Configuration for using Nerd Fonts Symbols."
  :type 'boolean
  :group 'appearance)


;; From now on, you'll see configurations using the `use-package' macro, which
;; allows us to organize our Emacs setup in a modular way. These configurations
;; look like this:
;;
;; (use-package some-package
;;   :ensure t  ;; Ensure the package is installed.
;;   :config    ;; Configuration settings for the package.
;;   ;; Additional settings can go here.
;; )
;;
;; This approach simplifies package management, enabling us to easily control
;; both built-in (first-party) and external (third-party) packages. While Emacs
;; is a vast and powerful editor, using `use-package' helps streamline our
;; configuration for better organization and customization. As we proceed,
;; you'll see smaller `use-package' declarations for specific packages, which
;; will help us enable the desired features and improve our workflow.


;;; Functions
(defun me/run-command (cmd)
  (let ((default-directory (car (last (project-current)))))
    (compile cmd)))

(defun me/proj-relative-buf-name ()
  (rename-buffer
   (file-relative-name buffer-file-name (car (last (project-current))))))

(add-hook 'find-file-hook #'me/proj-relative-buf-name)
;; (add-hook 'projectile-find-file-hook #'me/proj-relative-buf-name)

(defun mu-magit-kill-buffers ()
   "Restore window configuration and kill all Magit buffers."
    (interactive)
    (let ((buffers (magit-mode-get-buffers)))
      (magit-restore-window-configuration)
      (mapc #'bury-buffer buffers)))

(defun elixir-run-test ()
  (interactive
   (let* ((file-path (buffer-file-name))
          (default-directory (car (last (project-current))))
          (file (->> file-path (file-name-split) (last) (nth 0)))
          (extension (file-name-extension file))
          (target (if (string= extension "ex") (find-spec) file-path)))
         (compile (concat "mix test " target)))))

(setq gotospec-config
      '((ex . ((test-folder . "test")
               (source-strip-folder . "lib")
               (strip-file-suffix . "")
               (test-suffix . "_test.exs")))
        (exs . ((test-folder . "lib")
                (source-strip-folder . "test")
                (strip-file-suffix . "_test")
                (test-suffix . ".ex")))))

(defun gotospec ()
  (interactive
   (find-file (find-spec))))

(defun find-spec ()
  (let* ((project-root (car (last (project-current))))
         (file-path (buffer-file-name))
         (relative-file-path (file-relative-name file-path project-root))
         (file (->> file-path (file-name-split) (last) (nth 0)))
         (extension (file-name-extension file))
         (config (alist-get (intern extension) gotospec-config))
         (test-folder (file-name-as-directory (alist-get 'test-folder config)))
         (test-suffix (alist-get 'test-suffix config))
         (strip-file-suffix (alist-get 'strip-file-suffix config))
         (source-strip-folder (file-name-as-directory (alist-get 'source-strip-folder config)))
         (target (concat
                  project-root
                  test-folder
                  (string-remove-prefix
                   (file-name-as-directory source-strip-folder)
                   (file-name-directory relative-file-path))
                  (concat
                   (string-remove-suffix strip-file-suffix (file-name-sans-extension file))
                   test-suffix))))
    target))

;;; EMACS
;;  This is biggest one. Keep going, plugins (oops, I mean packages) will be shorter :)
(use-package emacs
  :ensure nil
  :custom                                         ;; Set custom variables to configure Emacs behavior.
  (column-number-mode t)                          ;; Display the column number in the mode line.
  (auto-save-default nil)                         ;; Disable automatic saving of buffers.
  (create-lockfiles nil)                          ;; Prevent the creation of lock files when editing.
  (delete-by-moving-to-trash t)                   ;; Move deleted files to the trash instead of permanently deleting them.
  (delete-selection-mode 1)                       ;; Enable replacing selected text with typed text.
  (display-line-numbers-type 'relative)           ;; Use relative line numbering in programming modes.
  (global-auto-revert-non-file-buffers t)         ;; Automatically refresh non-file buffers.
  (history-length 25)                             ;; Set the length of the command history.
  (inhibit-startup-message t)                     ;; Disable the startup message when Emacs launches.
  (initial-scratch-message "")                    ;; Clear the initial message in the *scratch* buffer.
  (ispell-dictionary "en_US")                     ;; Set the default dictionary for spell checking.
  (make-backup-files nil)                         ;; Disable creation of backup files.
  (pixel-scroll-precision-mode t)                 ;; Enable precise pixel scrolling.
  (pixel-scroll-precision-use-momentum nil)       ;; Disable momentum scrolling for pixel precision.
  (ring-bell-function 'ignore)                    ;; Disable the audible bell.
  (split-width-threshold 300)                     ;; Prevent automatic window splitting if the window width exceeds 300 pixels.
  (switch-to-buffer-obey-display-actions t)       ;; Make buffer switching respect display actions.
  ;; (tab-always-indent 'complete)                   ;; Make the TAB key complete text instead of just indenting.
  (css-indent-offset 2)                           ;; Use 2 spaces indent for css files
  (js-indent-level 2)                             ;; Use 2 space indent for js files
  (indent-tabs-mode nil)                          ;; Never insert tabs
  (treesit-font-lock-level 4)                     ;; Use advanced font locking for Treesit mode.
  (truncate-lines t)                              ;; Enable line truncation to avoid wrapping long lines.
  (use-dialog-box nil)                            ;; Disable dialog boxes in favor of minibuffer prompts.
  (use-short-answers t)                           ;; Use short answers in prompts for quicker responses (y instead of yes)
  (global-visual-line-mode t)
  (electric-pair-mode t)
  (compilation-scroll-output t)
  (compilation-always-kill t)
  (ruby-indent-level 2)
  (ruby-insert-encoding-magic-comment nil)
  (ruby-method-call-indent nil)
  (ruby-after-operator-indent nil)
  (ruby-parenless-call-arguments-indent nil)
  (ruby-method-params-indent 0)
  (ruby-block-indent nil)
  (ruby-align-chained-calls nil)
  (ruby-deep-indent-paren nil)
  (compilation-scroll-output t)
  (scroll-conservatively most-positive-fixnum)
  (scroll-margin 0)
  (project-switch-commands 'project-find-file)
  (warning-minimum-level :emergency)              ;; Set the minimum level of warnings to display.

  :hook                                           ;; Add hooks to enable specific features in certain modes.
  (prog-mode . display-line-numbers-mode)         ;; Enable line numbers in programming modes.
  (markdown-mode . display-line-numbers-mode)

  :config
  ;; By default emacs gives you access to a lot of *special* buffers, while navigating with [b and ]b,
  ;; this might be confusing for newcomers. This settings make sure ]b and [b will always load a
  ;; file buffer. To see all buffers use <leader> SPC, <leader> b l, or <leader> b i.
  (defun skip-these-buffers (_window buffer _bury-or-kill)
	"Function for `switch-to-prev-buffer-skip'."
	(string-match "\\*[^*]+\\*" (buffer-name buffer)))
  (setq switch-to-prev-buffer-skip 'skip-these-buffers)


  ;; Configure font settings based on the operating system.
  ;; Ok, this kickstart is meant to be used on the terminal, not on GUI.
  ;; But without this, I fear you could start Graphical Emacs and be sad :(
  (set-face-attribute 'default nil :family "JetBrainsMono Nerd Font"  :height 100)
  (when (eq system-type 'darwin)       ;; Check if the system is macOS.
    (setq mac-command-modifier 'meta)  ;; Set the Command key to act as the Meta key.
    (set-face-attribute 'default nil :family "JetBrainsMono Nerd Font" :height 130))

  ;; Save manual customizations to a separate file instead of cluttering `init.el'.
  ;; You can M-x customize, M-x customize-group, or M-x customize-themes, etc.
  ;; The saves you do manually using the Emacs interface would overwrite this file.
  ;; The following makes sure those customizations are in a separate file.
  (setq custom-file (locate-user-emacs-file "custom-vars.el")) ;; Specify the custom file path.
  (load custom-file 'noerror 'nomessage)                       ;; Load the custom file quietly, ignoring errors.

  :init                        ;; Initialization settings that apply before the package is loaded.
  (tool-bar-mode -1)           ;; Disable the tool bar for a cleaner interface.
  (menu-bar-mode -1)           ;; Disable the menu bar for a more streamlined look.
  (when scroll-bar-mode
    (scroll-bar-mode -1))      ;; Disable the scroll bar if it is active.

  (global-hl-line-mode 1)      ;; Enable highlight of the current line
  (global-auto-revert-mode 1)  ;; Enable global auto-revert mode to keep buffers up to date with their corresponding files.
  (indent-tabs-mode -1)        ;; Disable the use of tabs for indentation (use spaces instead).
  (recentf-mode 1)             ;; Enable tracking of recently opened files.
  (savehist-mode 1)            ;; Enable saving of command history.
  (save-place-mode 1)          ;; Enable saving the place in files for easier return.
  (winner-mode)                ;; Enable winner mode to easily undo window configuration changes.
  (xterm-mouse-mode 1)         ;; Enable mouse support in terminal mode.
  (file-name-shadow-mode 1)    ;; Enable shadowing of filenames for clarity.

  ;; Set the default coding system for files to UTF-8.
  (modify-coding-system-alist 'file "" 'utf-8)

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


;;; Compilation mode
(require 'ansi-color)
(defun my/ansi-colorize-buffer ()
  (let ((buffer-read-only nil))
    (ansi-color-apply-on-region (point-min) (point-max))))

(add-hook 'compilation-filter-hook 'my/ansi-colorize-buffer)

;;; Miscellaneous
(use-package balanced-windows
  :ensure t
  :config
  (balanced-windows-mode))

(use-package ws-butler
  :ensure t
  :hook prog-mode slim-mode)

;;; DIRED
;; In Emacs, the `dired' package provides a powerful and built-in file manager
;; that allows you to navigate and manipulate files and directories directly
;; within the editor. If you're familiar with `oil.nvim', you'll find that
;; `dired' offers similar functionality natively in Emacs, making file
;; management seamless without needing external plugins.

;; This configuration customizes `dired' to enhance its usability. The settings
;; below specify how file listings are displayed, the target for file operations,
;; and associations for opening various file types with their respective applications.
;; For example, image files will open with `feh', while audio and video files
;; will utilize `mpv'.
(use-package dired
  :ensure nil                                                ;; This is built-in, no need to fetch it.
  :custom
  (dired-listing-switches "-lah --group-directories-first")  ;; Display files in a human-readable format and group directories first.
  (dired-dwim-target t)                                      ;; Enable "do what I mean" for target directories.
  (dired-guess-shell-alist-user
   '(("\\.\\(png\\|jpe?g\\|tiff\\)" "feh" "xdg-open" "open") ;; Open image files with `feh' or the default viewer.
     ("\\.\\(mp[34]\\|m4a\\|ogg\\|flac\\|webm\\|mkv\\)" "mpv" "xdg-open" "open") ;; Open audio and video files with `mpv'.
     (".*" "open" "xdg-open")))                              ;; Default opening command for other files.
  (dired-kill-when-opening-new-dired-buffer t)               ;; Close the previous buffer when opening a new `dired' instance.
  :config
  (when (eq system-type 'darwin)
    (let ((gls (executable-find "gls")))                     ;; Use GNU ls on macOS if available.
      (when gls
        (setq insert-directory-program gls)))))


;;; ELDOC
;; Eldoc provides helpful inline documentation for functions and variables
;; in the minibuffer, enhancing the development experience. It can be particularly useful
;; in programming modes, as it helps you understand the context of functions as you type.
;; This package is built-in, so there's no need to fetch it separately.
;; The following line enables Eldoc globally for all buffers.
(use-package eldoc
  :ensure nil          ;; This is built-in, no need to fetch it.
  :init
  (global-eldoc-mode))


;;; FLYMAKE
;; Flymake is an on-the-fly syntax checking extension that provides real-time feedback
;; about errors and warnings in your code as you write. This can greatly enhance your
;; coding experience by catching issues early. The configuration below activates
;; Flymake mode in programming buffers.
(use-package flymake
  :ensure nil          ;; This is built-in, no need to fetch it.
  :defer t
  :hook (rust-ts-mode . flymake-mode)
  :custom
  (flymake-margin-indicators-string
   '((error "!»" compilation-error) (warning "»" compilation-warning)
	 (note "»" compilation-info))))


;;; ORG-MODE
;; Org-mode is a powerful system for organizing and managing your notes,
;; tasks, and documents in plain text. It offers features like task management,
;; outlining, scheduling, and much more, making it a versatile tool for
;; productivity. The configuration below simply defers loading Org-mode until
;; it's explicitly needed, which can help speed up Emacs startup time.
(use-package org
  :ensure nil     ;; This is built-in, no need to fetch it.
  :defer t)       ;; Defer loading Org-mode until it's needed.


;;; ==================== EXTERNAL PACKAGES ====================
;;
;; From this point onward, all configurations will be for third-party packages
;; that enhance Emacs' functionality and extend its capabilities.

;;; VERTICO
;; Vertico enhances the completion experience in Emacs by providing a
;; vertical selection interface for both buffer and minibuffer completions.
;; Unlike traditional minibuffer completion, which displays candidates
;; in a horizontal format, Vertico presents candidates in a vertical list,
;; making it easier to browse and select from multiple options.
;;
;; In buffer completion, `switch-to-buffer' allows you to select from open buffers.
;; Vertico streamlines this process by displaying the buffer list in a way that
;; improves visibility and accessibility. This is particularly useful when you
;; have many buffers open, allowing you to quickly find the one you need.
;;
;; In minibuffer completion, such as when entering commands or file paths,
;; Vertico helps by showing a dynamic list of potential completions, making
;; it easier to choose the correct one without typing out the entire string.
(use-package vertico
  :ensure t
  :hook
  (after-init . vertico-mode)           ;; Enable vertico after Emacs has initialized.
  :custom
  (vertico-count 15)                    ;; Number of candidates to display in the completion list.
  (vertico-resize nil)                  ;; Disable resizing of the vertico minibuffer.
  (vertico-cycle nil)                   ;; Do not cycle through candidates when reaching the end of the list.
  (completion-styles '(basic partial-completion orderless))
  :bind (:map vertico-map
			  ("C-j" . vertico-next)
			  ("C-k" . vertico-previous)
			  ("C-f" . vertico-exit)
			  :map minibuffer-local-map
			  ("M-h" . backward-kill-word)))

(use-package vertico-directory
  :ensure nil
  :after vertico
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

;;; ORDERLESS
;; Orderless enhances completion in Emacs by allowing flexible pattern matching.
;; It works seamlessly with Vertico, enabling you to use partial strings and
;; regular expressions to find files, buffers, and commands more efficiently.
;; This combination provides a powerful and customizable completion experience.
(use-package orderless
  :ensure t
  :defer t                                    ;; Load Orderless on demand.
  :after vertico                              ;; Ensure Vertico is loaded before Orderless.
  :init
  (setq completion-styles '(orderless basic)  ;; Set the completion styles.
        completion-category-overrides '((file (styles partial-completion))))) ;; Customize file completion styles.


;;; MARGINALIA
;; Marginalia enhances the completion experience in Emacs by adding
;; additional context to the completion candidates. This includes
;; helpful annotations such as documentation and other relevant
;; information, making it easier to choose the right option.
(use-package marginalia
  :ensure t
  :hook
  (after-init . marginalia-mode))


;;; Projectile

(use-package projectile
  :ensure t
  :custom
  (projectile-project-search-path '("~/Development" "~/dotfiles" "~/.emacs.d"))
  (projectile-create-missing-test-files t))

;;; CONSULT
;; Consult provides powerful completion and narrowing commands for Emacs.
;; It integrates well with other completion frameworks like Vertico, enabling
;; features like previews and enhanced register management. It's useful for
;; navigating buffers, files, and xrefs with ease.
(use-package consult
  :ensure t
  :defer t
  :custom
  (consult-preview-key nil)
  :init
  ;; Enhance register preview with thin lines and no mode line.
  (advice-add #'register-preview :override #'consult-register-window))

  ;; Use Consult for xref locations with a preview feature.
  ;; (setq xref-show-xrefs-function #'consult-xref
  ;;       xref-show-definitions-function #'consult-xref))

(unless (package-installed-p 'consult-vc-modified-files)
  (package-vc-install "https://github.com/chmouel/consult-vc-modified-files"))
(use-package consult-vc-modified-files :ensure t)

;;; TREESITTER-AUTO
;; Treesit-auto simplifies the use of Tree-sitter grammars in Emacs,
;; providing automatic installation and mode association for various
;; programming languages. This enhances syntax highlighting and
;; code parsing capabilities, making it easier to work with modern
;; programming languages.
(use-package treesit-auto
  :ensure t
  :after emacs
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (add-to-list 'auto-mode-alist '("\\.cr$" . crystal-mode))
  (add-to-list 'auto-mode-alist '("\\.ex\\'" . elixir-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.exs\\'" . elixir-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.gleam\\'" . gleam-ts-mode))
  (global-treesit-auto-mode t))


;;; SLIM-MODE
(use-package slim-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.emblem$" . slim-mode)))

;;; MARKDOWN-MODE
;; Markdown Mode provides support for editing Markdown files in Emacs,
;; enabling features like syntax highlighting, previews, and more.
;; It’s particularly useful for README files, as it can be set
;; to use GitHub Flavored Markdown for enhanced compatibility.
(use-package markdown-mode
  :defer t
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)            ;; Use gfm-mode for README.md files.
  :init (setq markdown-command "multimarkdown")) ;; Set the Markdown processing command.


;;; SNIPPETS
(use-package yasnippet
  :ensure t
  :defer t
  :init (yas-global-mode 1))

;;; POPPER
(use-package popper
  :ensure t
  :bind (("C-`"   . popper-toggle)
         ("M-`"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :custom
  (popper-reference-buffers
        '("\\*Async Shell Command\\*"
          "*rspec-compilation*"
          "*mix test*"
          "*RuboCop"
          "*cider-repl"
          "*cider-error*"
          "*cider-test-report"
          "*Help*"
          "*eldoc"
          "*grep"
          "*grep*"
          "*xref*"
          "*eshell*"
          "-eshell*"
          "*rg*"
          "*compilation*"
          "\\*Bundler\\*"))
  (popper-window-height (lambda (win)
                               (->
                                window-total-height
                                (/ 2.5)
                                (floor))))
  (popper-display-function 'popper-display-popup-at-bottom)
  :init
  (popper-mode +1)
  (popper-echo-mode +1))

;;; COMPANY
;; Company Mode provides a text completion framework for Emacs.
;; It enhances the editing experience by offering context-aware
;; suggestions as you type. With support for multiple backends,
;; Company Mode is highly customizable and can be integrated with
;; various modes and languages.
(use-package company
  :ensure t
  :custom
  (company-tooltip-align-annotations t)      ;; Align annotations with completions.
  (company-minimum-prefix-length 1)          ;; Trigger completion after typing 1 character
  (company-idle-delay 0.2)                   ;; Delay before showing completion (adjust as needed)
  (company-tooltip-maximum-width 50)
  (company-backends '((company-yasnippet :separate company-capf company-dabbrev)))
  :config

  ;; While using C-p C-n to select a completion candidate
  ;; C-y quickly shows help docs for the current candidate
  (define-key company-active-map (kbd "C-y")
			  (lambda ()
				(interactive)
				(company-show-doc-buffer)))
  (define-key company-active-map [tab] 'company-complete-selection)
  (define-key company-active-map (kbd "TAB") 'company-complete-selection)
  (define-key company-active-map [ret] 'company-complete-selection)
  (define-key company-active-map (kbd "RET") 'company-complete-selection)
  :hook
  (prog-mode . company-mode)
  (markdown-mode . company-mode))


;;; Eglot
(use-package eglot
  :ensure nil
  :hook
  (ruby-ts-mode . eglot-ensure)
  (ruby-mode . eglot-ensure)
  (elixir-ts-mode . eglot-ensure)
  (typescript-ts-mode . eglot-ensure)
  (gleam-ts-mode . eglot-ensure)
  (rust-ts-mode . eglot-ensure)
  :init
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
  :vc (:url "https://github.com/blahgeek/emacs-lsp-booster"
            :branch "master")
  :after eglot
  :config (eglot-booster-mode))

;;; FORMATTING
(use-package ws-butler
  :ensure t
  :hook prog-mode slim-mode)

(use-package reformatter
  :ensure t
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

;;; LSP Additional Servers
;; You can extend `lsp-mode' by integrating additional language servers for specific
;; technologies. For example, `lsp-tailwindcss' provides support for Tailwind CSS
;; classes within your HTML files. By using various LSP packages, you can connect
;; multiple LSP servers simultaneously, enhancing your coding experience across
;; different languages and frameworks.
;(use-package lsp-tailwindcss
;  :ensure t
;  :defer t
;  :config
;  (add-to-list 'lsp-language-id-configuration '(".*\\.erb$" . "html")) ;; Associate ERB files with HTML.
;  :init
;  (setq lsp-tailwindcss-add-on-mode t))


;;; Diff-HL
;; The `diff-hl' package provides visual indicators for version control changes
;; directly in the margin of the buffer, showing lines added, deleted, or changed.
;; This is useful for tracking modifications while you edit files. When enabled,
;; it automatically activates in every buffer that has a corresponding version
;; control backend, offering a seamless experience.
;;
;; In comparison, Neovim users often rely on plugins like `gitsigns.nvim' or
;; `vim-signify', which provide similar functionalities by displaying Git
;; changes in the gutter and offer additional features like highlighting
;; changed lines and displaying blame information. `diff-hl' aims to provide
;; a comparable experience in Emacs with its own set of customizations.
(use-package diff-hl
  :defer t
  :ensure t
  :hook
  (find-file . (lambda ()
                 (global-diff-hl-mode)           ;; Enable Diff-HL mode for all files.
                 (diff-hl-flydiff-mode)          ;; Automatically refresh diffs.
                 (diff-hl-margin-mode)))         ;; Show diff indicators in the margin.
  :custom
  (diff-hl-side 'left)                           ;; Set the side for diff indicators.
  (diff-hl-margin-symbols-alist '((insert . "│") ;; Customize symbols for each change type.
                                   (delete . "-")
                                   (change . "│")
                                   (unknown . "?")
                                   (ignored . "i"))))


;;; Magit
;; `magit' is a powerful Git interface for Emacs that provides a complete
;; set of features to manage Git repositories. With its intuitive interface,
;; you can easily stage, commit, branch, merge, and perform other Git
;; operations directly from Emacs. Magit’s powerful UI allows for a seamless
;; workflow, enabling you to visualize your repository's history and manage
;; changes efficiently.
;;
;; In the Neovim ecosystem, similar functionality is provided by plugins such as
;; `fugitive.vim', which offers a robust Git integration with commands that
;; allow you to perform Git operations directly within Neovim. Another popular
;; option is `neogit', which provides a more modern and user-friendly interface
;; for Git commands in Neovim, leveraging features like diff views and staging
;; changes in a visual format. Both of these plugins aim to replicate and
;; extend the powerful capabilities that Magit offers in Emacs.
(use-package magit
  :ensure t
  :defer t
  :custom
  (magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1)
  :config
  (add-hook 'git-commit-mode-hook 'evil-insert-state))


;;; XCLIP
;; `xclip' is an Emacs package that integrates the X Window System clipboard
;; with Emacs. It allows seamless copying and pasting between Emacs and other
;; applications using the clipboard. When `xclip' is enabled, any text copied
;; in Emacs can be pasted in other applications, and vice versa, providing a
;; smooth workflow when working across multiple environments.
(use-package xclip
  :ensure t
  :defer t
  :hook
  (after-init . xclip-mode))     ;; Enable xclip mode after initialization.


;;; INDENT-GUIDE
;; The `indent-guide' package provides visual indicators for indentation levels
;; in programming modes, making it easier to see code structure at a glance.
;; It draws vertical lines (by default, a character of your choice) at each
;; level of indentation, helping to improve readability and navigation within
;; the code.
(use-package indent-guide
  :defer t
  :ensure t
  :hook
  (prog-mode . indent-guide-mode)  ;; Activate indent-guide in programming modes.
  :config
  (setq indent-guide-char "│"))    ;; Set the character used for the indent guide.

;; EVIL
;; The `evil' package provides Vim emulation within Emacs, allowing
;; users to edit text in a modal way, similar to how Vim
;; operates. This setup configures `evil-mode' to enhance the editing
;; experience.
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
  (evil-define-key 'normal rspec-compilation-mode-map (kbd "J") 'compilation-next-error)
  (evil-define-key 'normal rspec-compilation-mode-map (kbd "K") 'compilation-previous-error)
  (evil-define-key 'normal compilation-mode-map (kbd "C-k") (lambda () (interactive) (select-window (previous-window))))
  (evil-define-key 'normal rspec-compilation-mode-map (kbd "C-k") (lambda () (interactive) (select-window (previous-window))))
  (evil-define-key 'normal 'global (kbd "]d") 'flymake-goto-next-error)
  (evil-define-key 'normal 'global (kbd "[d") 'flymake-goto--previous-error)
  (evil-define-key 'normal 'global (kbd "]h") 'diff-hl-next-hunk)
  (evil-define-key 'normal 'global (kbd "[h") 'diff-hl-previous-hunk)
  (evil-define-key 'insert 'global (kbd "C-e") 'end-of-line)
  (evil-define-key 'insert 'global (kbd "C-a") 'beginning-of-line)
  (evil-define-key 'normal 'global (kbd "<escape>") (lambda () (interactive) (popper--bury-all)))
  (evil-define-key 'normal 'global (kbd "gt") 'evil-avy-goto-char-2)
  (evil-define-key 'normal 'global (kbd "<leader>/") 'counsel-ag)
  (evil-define-key 'normal 'global (kbd "<leader>hv") 'describe-variable)
  (evil-define-key 'normal 'global (kbd "<leader>hf") 'describe-function)
  (evil-define-key 'normal 'global (kbd "<leader>hk") 'describe-key)
  (evil-define-key 'normal 'global (kbd "<leader>bd") (lambda () (interactive) (kill-buffer (current-buffer))))
  (evil-define-key 'normal 'global (kbd "<leader>wu") 'winner-undo)
  (evil-define-key 'normal 'global (kbd "<leader>wv") 'split-window-right)
  (evil-define-key 'normal 'global (kbd "<leader>wh") 'split-window-below)
  (evil-define-key 'normal 'global (kbd "<leader>wd") 'delete-window)
  (evil-define-key 'normal 'global (kbd "<leader>wq") 'delete-window)
  (evil-define-key 'normal 'global (kbd "<leader>wr") 'winner-redo)
  (evil-define-key 'normal 'global (kbd "<leader>sr") 'anzu-query-replace-regexp)
  (evil-define-key 'normal 'global (kbd "<leader>bb") 'consult-project-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>pp") 'project-switch-project)
  (evil-define-key 'normal 'global (kbd "<leader>pf") 'project-find-file)
  (evil-define-key 'normal 'global (kbd "<leader>SPC") 'project-find-file)
  (evil-define-key 'normal 'global (kbd "<leader>ff") 'find-file)
  (evil-define-key 'normal 'global (kbd "<leader>fd") 'projectile-find-dir)
  (evil-define-key 'normal 'global (kbd "<leader>ca") 'eglot-code-actions)
  (evil-define-key 'normal 'global (kbd "<leader>cf") 'lsp-format-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>cc") 'lsp-workspace-restart)
  (evil-define-key 'normal 'global (kbd "<leader>cd") 'lsp-find-definition)
  (evil-define-key 'normal 'global (kbd "<leader>cD") 'xref-find-definitions-other-window)
  (evil-define-key 'normal 'global (kbd "<leader>cr") 'lsp-find-references)
  (evil-define-key 'normal 'global (kbd "<leader>gg") 'magit)
  (evil-define-key 'normal 'global (kbd "<leader>gm") 'consult-vc-modified-files)
  (evil-define-key 'normal 'global (kbd "<leader>gc") 'magit-branch-or-checkout)
  (evil-define-key 'normal 'global (kbd "<leader>gF") 'magit-pull)
  (evil-define-key '(normal visual) 'global (kbd "<leader>gl") 'git-link)
  (evil-define-key 'normal 'global (kbd "<leader>gb") 'magit-blame)
  (evil-define-key 'normal magit-status-mode-map (kbd "q") 'mu-magit-kill-buffers)
  (evil-define-key 'normal magit-status-mode-map (kbd "<escape>") 'mu-magit-kill-buffers)
  (evil-define-key 'normal ruby-ts-mode-map (kbd "<leader>tt") 'rspec-toggle-spec-and-target)
  (evil-define-key 'normal ruby-ts-mode-map (kbd "<leader>tv") 'rspec-verify)
  (evil-define-key 'normal ruby-ts-mode-map (kbd "<leader>tl") 'rspec-rerun)
  (evil-define-key 'normal ruby-ts-mode-map (kbd "<leader>tf") 'rspec-run-last-failed)
  (evil-define-key 'normal ruby-ts-mode-map (kbd "<leader>tc") 'rspec-verify-single)
  (evil-define-key 'normal ruby-ts-mode-map (kbd "<leader>ta") 'rspec-verify-all)
  (evil-define-key 'normal ruby-ts-mode-map (kbd "<leader>mp") (lambda () (interactive) (me/run-command "bundle exec rubocop")))
  (evil-define-key 'normal ruby-ts-mode-map (kbd "<leader>mbi") (lambda () (interactive) (me/run-command "bundle install")))
  (evil-define-key 'normal ruby-mode-map (kbd "<leader>tt") 'rspec-toggle-spec-and-target)
  (evil-define-key 'normal ruby-mode-map (kbd "<leader>tv") 'rspec-verify)
  (evil-define-key 'normal ruby-mode-map (kbd "<leader>tl") 'rspec-rerun)
  (evil-define-key 'normal ruby-mode-map (kbd "<leader>tf") 'rspec-run-last-failed)
  (evil-define-key 'normal ruby-mode-map (kbd "<leader>tc") 'rspec-verify-single)
  (evil-define-key 'normal ruby-mode-map (kbd "<leader>ta") 'rspec-verify-all)
  (evil-define-key 'normal ruby-mode-map (kbd "<leader>mp") (lambda () (interactive) (me/run-command "bundle exec rubocop")))
  (evil-define-key 'normal ruby-mode-map (kbd "<leader>mbi") (lambda () (interactive) (me/run-command "bundle install")))
  (evil-define-key 'normal rust-ts-mode-map (kbd "<leader>ta") 'rust-test)
  (evil-define-key 'normal rust-ts-mode-map (kbd "<leader>mr") 'rust-run)
  (evil-define-key 'normal rust-ts-mode-map (kbd "<leader>mb") 'rust-compile)
  (evil-define-key 'normal rust-ts-mode-map (kbd "<leader>mf") 'rust-format-buffer)
  (evil-define-key 'normal typescript-ts-mode-map (kbd "<leader>mb") (lambda () (interactive) (me/run-command "npx tsc")))
  (evil-define-key 'normal clojure-mode-map (kbd "<leader>md") 'cider-clojuredocs)
  (evil-define-key 'normal clojure-mode-map (kbd "<leader>mc") 'cider)
  (evil-define-key 'normal clojure-mode-map (kbd "<leader>tt") 'projectile-toggle-between-implementation-and-test)
  (evil-define-key 'normal clojure-mode-map (kbd "<leader>ta") 'cider-test-run-project-tests)
  (evil-define-key 'normal clojure-mode-map (kbd "<leader>tv") 'cider-test-run-ns-tests)
  (evil-define-key 'normal clojure-mode-map (kbd "<leader>tc") 'cider-test-run-test)
  (evil-define-key 'normal clojure-mode-map (kbd "<leader>tn") 'cider-test-run-ns-tests)
  (evil-define-key 'normal clojure-mode-map (kbd "<leader>eb") 'cider-eval-buffer)
  (evil-define-key 'normal clojure-mode-map (kbd "<leader>er") 'cider-eval-defun-at-point)
  (evil-define-key 'normal clojure-mode-map (kbd "<leader>ee") 'cider-eval-last-sexp)
  (evil-define-key 'normal clojure-mode-map (kbd "<leader>rr") 'cider-ns-refresh)
  (evil-define-key 'normal clojure-mode-map (kbd "<leader>rn") 'cider-repl-set-ns)
  (evil-define-key 'normal clojure-mode-map (kbd "<leader>rb") 'cider-switch-to-repl-buffer)
  (evil-define-key 'normal emacs-lisp-mode-map (kbd "<leader>eb") 'eval-buffer)
  (evil-define-key 'normal emacs-lisp-mode-map (kbd "<leader>ee") 'eval-last-sexp)
  (evil-define-key 'normal elixir-ts-mode-map (kbd "<leader>fm") 'eglot-format)
  (evil-define-key 'normal elixir-ts-mode-map (kbd "<leader>ta") '(lambda () (interactive) (me/run-command "mix test")))
  (evil-define-key 'normal elixir-ts-mode-map (kbd "<leader>tv") 'elixir-run-test)
  (evil-define-key 'normal elixir-ts-mode-map (kbd "<leader>tc") 'mix-test-current-test)
  (evil-define-key 'normal elixir-ts-mode-map (kbd "<leader>tt") 'gotospec)
  (evil-define-key 'normal elixir-ts-mode-map (kbd "<leader>mp") (lambda () (interactive) (me/run-command "mix credo")))
  (evil-define-key 'normal elixir-ts-mode-map (kbd "<leader>mf") (lambda () (interactive) (me/run-command "mix format")))
  (evil-define-key 'normal elixir-ts-mode-map (kbd "<leader>md") (lambda () (interactive) (me/run-command "mix deps.get")))
  (evil-define-key 'normal go-mode-map (kbd "<leader>tt") 'projectile-toggle-between-implementation-and-test)
  (evil-define-key 'normal go-mode-map (kbd "<leader>tv") 'go-test-current-file)
  (evil-define-key 'normal go-mode-map (kbd "<leader>tc") 'go-test-current-test)
  (evil-define-key 'normal go-mode-map (kbd "<leader>ta") 'go-test-current-project)
  (evil-define-key 'normal gleam-ts-mode-map (kbd "<leader>ta") (lambda () (interactive) (me/run-command "gleam test")))
  (evil-define-key 'normal crystal-mode-map (kbd "<leader>tt") 'projectile-toggle-between-implementation-and-test)
  (evil-define-key 'normal crystal-mode-map (kbd "<leader>mp") (lambda () (interactive) (me/run-command "./bin/ameba")))
  (evil-define-key 'normal crystal-mode-map (kbd "<leader>mf") (lambda () (interactive) (me/run-command "crystal tool format")))
  (evil-define-key 'normal crystal-mode-map (kbd "<leader>mbi") (lambda () (interactive) (me/run-command "shards install")))
  (evil-define-key 'normal crystal-mode-map (kbd "<leader>mbb") (lambda () (interactive) (me/run-command "shards build")))
  (evil-define-key 'normal crystal-mode-map (kbd "<leader>mp") (lambda () (interactive) (me/run-command "./bin/ameba")))
  (evil-define-key 'normal crystal-mode-map (kbd "<leader>ta") (lambda () (interactive) (me/run-command "crystal spec")))

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


  ;; Enable evil mode
  (evil-mode 1))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))


;; EVIL COLLECTION
;; The `evil-collection' package enhances the integration of
;; `evil-mode' with various built-in and third-party packages. It
;; provides a better modal experience by remapping keybindings and
;; commands to fit the `evil' style.
(use-package evil-collection
  :after evil
  :defer t
  :ensure t
  ;; Hook to initialize `evil-collection' when `evil-mode' is activated.
  :hook
  (evil-mode . evil-collection-init)
  :config
  (evil-collection-init))


;;; RAINBOW DELIMITERS
;; The `rainbow-delimiters' package provides colorful parentheses, brackets, and braces
;; to enhance readability in programming modes. Each level of nested delimiter is assigned
;; a different color, making it easier to match pairs visually.
(use-package rainbow-delimiters
  :defer t
  :ensure t
  :hook
  (prog-mode . rainbow-delimiters-mode))


;;; Crystal
(use-package crystal-mode
  :ensure t
  :config
  (setenv "CRYSTAL_OPTS" "--link-flags=-Wl,-ld_classic"))

;;; GLEAM
(use-package gleam-ts-mode :mode (rx ".gleam" eos))

;;; RUST
(use-package rust-mode :ensure t)

;;; RUBY
(use-package inf-ruby :ensure t
  :config
  (inf-ruby-enable-auto-breakpoint))

(use-package ruby-end
  :defer t
  :ensure t)

(use-package rspec-mode
  :ensure t
  :defer t
  :commands (rspec-toggle-spec-and-target rspec-verify rspec-rerun rspec-run-last-failed rspec-verify-single rspec-verify-all)
  :custom
  (rspec-primary-source-dirs '("app" "apps" "lib")))

;;; PULSAR
;; The `pulsar' package enhances the user experience in Emacs by providing
;; visual feedback through pulsating highlights. This feature is especially
;; useful in programming modes, where it can help users easily track
;; actions such as scrolling, error navigation, yanking, deleting, and
;; jumping to definitions.
(use-package pulsar
  :defer t
  :ensure t
  :hook
  (after-init . pulsar-global-mode)
  :config
  (setq pulsar-pulse t)
  (setq pulsar-delay 0.025)
  (setq pulsar-iterations 10)
  (setq pulsar-face 'evil-ex-lazy-highlight)

  (add-to-list 'pulsar-pulse-functions 'evil-scroll-down)
  (add-to-list 'pulsar-pulse-functions 'flymake-goto-next-error)
  (add-to-list 'pulsar-pulse-functions 'flymake-goto-prev-error)
  (add-to-list 'pulsar-pulse-functions 'evil-yank)
  (add-to-list 'pulsar-pulse-functions 'evil-yank-line)
  (add-to-list 'pulsar-pulse-functions 'evil-delete)
  (add-to-list 'pulsar-pulse-functions 'evil-delete-line)
  (add-to-list 'pulsar-pulse-functions 'evil-jump-item)
  (add-to-list 'pulsar-pulse-functions 'diff-hl-next-hunk)
  (add-to-list 'pulsar-pulse-functions 'diff-hl-previous-hunk))


;;; DOOM MODELINE
;; The `doom-modeline' package provides a sleek, modern mode-line that is visually appealing
;; and functional. It integrates well with various Emacs features, enhancing the overall user
;; experience by displaying relevant information in a compact format.

(use-package doom-modeline
  :ensure t
  :defer t
  :custom
  (doom-modeline-buffer-file-name-style 'buffer-name)  ;; Set the buffer file name style to just the buffer name (without path).
  (doom-modeline-project-detection 'project)           ;; Enable project detection for displaying the project name.
  (doom-modeline-buffer-name t)                        ;; Show the buffer name in the mode line.
  (doom-modeline-vcs-max-length 25)                    ;; Limit the version control system (VCS) branch name length to 25 characters.
  (doom-modeline-buffer-file-name 'relative-from-project)
  :config
  (if ek-use-nerd-fonts                                ;; Check if nerd fonts are being used.
      (setq doom-modeline-icon t)                      ;; Enable icons in the mode line if nerd fonts are used.
    (setq doom-modeline-icon nil))                     ;; Disable icons if nerd fonts are not being used.
  :hook
  (after-init . doom-modeline-mode))


;;; NEOTREE
;; The `neotree' package provides a file tree explorer for Emacs, allowing easy navigation
;; through directories and files. It presents a visual representation of the file system
;; and integrates with version control to show file states.
(use-package neotree
  :ensure t
  :custom
  (neo-show-hidden-files t)                ;; By default shows hidden files (toggle with H)
  (neo-theme 'nerd)                        ;; Set the default theme for Neotree to 'nerd' for a visually appealing look.
  (neo-vc-integration '(face char))        ;; Enable VC integration to display file states with faces (color coding) and characters (icons).
  :defer t                                 ;; Load the package only when needed to improve startup time.
  :config
  (if ek-use-nerd-fonts                    ;; Check if nerd fonts are being used.
      (setq neo-theme 'nerd-icons)         ;; Set the theme to 'nerd-icons' if nerd fonts are available.
	(setq neo-theme 'nerd))                ;; Otherwise, fall back to the 'nerd' theme.
  :init
  (add-hook 'neo-after-create-hook
			#'(lambda (_)
				(with-current-buffer (get-buffer neo-buffer-name)
				  (setq truncate-lines t)
				  (setq word-wrap nil)
				  (make-local-variable 'auto-hscroll-mode)
				  (setq auto-hscroll-mode nil)))))


;;; NERD ICONS
;; The `nerd-icons' package provides a set of icons for use in Emacs. These icons can
;; enhance the visual appearance of various modes and packages, making it easier to
;; distinguish between different file types and functionalities.
(use-package nerd-icons
  :if ek-use-nerd-fonts                   ;; Load the package only if the user has configured to use nerd fonts.
  :ensure t                               ;; Ensure the package is installed.
  :defer t)                               ;; Load the package only when needed to improve startup time.


;;; NERD ICONS Dired
;; The `nerd-icons-dired' package integrates nerd icons into the Dired mode,
;; providing visual icons for files and directories. This enhances the Dired
;; interface by making it easier to identify file types at a glance.
(use-package nerd-icons-dired
  :if ek-use-nerd-fonts                   ;; Load the package only if the user has configured to use nerd fonts.
  :ensure t                               ;; Ensure the package is installed.
  :defer t                                ;; Load the package only when needed to improve startup time.
  :hook
  (dired-mode . nerd-icons-dired-mode))


;;; NERD ICONS COMPLETION
;; The `nerd-icons-completion' package enhances the completion interfaces in
;; Emacs by integrating nerd icons with completion frameworks such as
;; `marginalia'. This provides visual cues for the completion candidates,
;; making it easier to distinguish between different types of items.
(use-package nerd-icons-completion
  :if ek-use-nerd-fonts                   ;; Load the package only if the user has configured to use nerd fonts.
  :ensure t                               ;; Ensure the package is installed.
  :after (:all nerd-icons marginalia)     ;; Load after `nerd-icons' and `marginalia' to ensure proper integration.
  :config
  (nerd-icons-completion-mode)            ;; Activate nerd icons for completion interfaces.
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup)) ;; Setup icons in the marginalia mode for enhanced completion display.


;;; CATPPUCCIN THEME
;; The `catppuccin-theme' package provides a visually pleasing color theme
;; for Emacs that is inspired by the popular Catppuccin color palette.
;; This theme aims to create a comfortable and aesthetic coding environment
;; with soft colors that are easy on the eyes.
(use-package catppuccin-theme
  :ensure t
  :config
  (custom-set-faces
   ;; Set the color for changes in the diff highlighting to blue.
   `(diff-hl-change ((t (:background unspecified :foreground ,(catppuccin-get-color 'blue))))))

  (custom-set-faces
   ;; Set the color for deletions in the diff highlighting to red.
   `(diff-hl-delete ((t (:background unspecified :foreground ,(catppuccin-get-color 'red))))))

  (custom-set-faces
   ;; Set the color for insertions in the diff highlighting to green.
   `(diff-hl-insert ((t (:background unspecified :foreground ,(catppuccin-get-color 'green))))))

  ;; Load the Catppuccin theme without prompting for confirmation.
  (load-theme 'catppuccin :no-confirm))


;;; UTILITARY FUNCTION TO INSTALL EMACS-KICK
(defun ek/first-install ()
  "Install tree-sitter grammars and compile packages on first run..."
  (interactive)                                      ;; Allow this function to be called interactively.
  (switch-to-buffer "*Messages*")                    ;; Switch to the *Messages* buffer to display installation messages.
  (message ">>> All required packages installed.")
  (message ">>> Configuring Emacs-Kick...")
  (message ">>> Configuring Tree Sitter parsers...")
  (require 'treesit-auto)
  (treesit-auto-install-all)                         ;; Install all available Tree Sitter grammars.
  (message ">>> Configuring Nerd Fonts...")
  (require 'nerd-icons)
  (nerd-icons-install-fonts)                         ;; Install all available nerd-fonts
  (message ">>> Native compile 3rd-party packages...\n")
  (require 'comp)
  (native-compile-prune-cache)                       ;; Prune the native compilation cache to free up resources.
  ;; Iterate through all directories in the user's package directory.
  (dolist (dir (directory-files package-user-dir t "^[^.]" t))
    (when (file-directory-p dir)                     ;; Check if the current entry is a directory.
      (byte-recompile-directory dir 0 t)             ;; Byte compile all files in the directory.
      (native-compile-async dir 'recursively)))      ;; Asynchronously compile the directory and its subdirectories.

  (message ">>> Emacs-Kick installed!!! Press any key to close the installer and open Emacs normally.") ;; Notify the user that the installation is complete.
  (read-key)                                         ;; Wait for the user to press any key.
  (kill-emacs))                                      ;; Close Emacs after installation is complete.

(provide 'init)
;;; init.el ends here
