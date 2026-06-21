;;; -*- lexical-binding: t; -*-

;; No frame decorations (no title bar)
(setq default-frame-alist '((undecorated . t)))

;; UI
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Basics
(setq initial-buffer-choice t)
(setq use-short-answers t)
(setq next-screen-context-lines 10)
(setq fill-column 78)
(auto-fill-mode)
(setq tab-always-indent 'complete)
(setq-default indent-tabs-mode nil)
(setq initial-scratch-message nil)
(setq-default x-stretch-cursor t)
(setq visible-bell nil)
(setq ring-bell-function 'ignore)
(setq kill-region-dwim 'emacs-word)
(setq exchange-point-and-mark-highlight-region nil)
(column-number-mode)
(add-to-list 'save-some-buffers-action-alist
             (list "d" (lambda (buffer)
                         (diff-buffer-with-file (buffer-file-name buffer)))))
(setq custom-file (make-temp-file "emacs-custom-"))
(setq enable-recursive-minibuffers t)

;; Keymaps
(global-set-key (kbd "C-x k") 'kill-current-buffer)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "C-c s") 'scratch-buffer)
(global-set-key (kbd "C-c I") (lambda () (interactive) (find-file user-init-file)))
(global-set-key (kbd "C-c Q") 'restart-emacs)
(global-set-key (kbd "M-u") 'upcase-dwim)
(global-set-key (kbd "M-l") 'downcase-dwim)
(global-set-key (kbd "M-c") 'capitalize-dwim)

;; Enable functionality
(mapc
 (lambda (command)
   (put command 'disabled nil))
 '(narrow-to-region narrow-to-page))

;; Disable functionality
(mapc
 (lambda (command)
   (put command 'disabled t))
 '(iconify-frame))

;; Backup/autosave/lockfiles
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; Use-package
(use-package use-package
  :custom
  (use-package-hook-name-suffix nil)
  (use-package-always-ensure nil))

;; Help
(use-package help
  :custom
  (help-window-select t)
  (help-window-keep-selected))

;; Winner mode
(use-package winner
  :hook
  (after-init-hook . winner-mode))

;; Dired
(use-package dired
  :hook
  ((dired-mode-hook . dired-hide-details-mode)
   (dired-mode-hook . hl-line-mode)
   (dired-mode-hook . auto-revert-mode))
  :custom
  (dired-recursive-copies 'always)
  (dired-recursive-deletes 'always)
  (dired-kill-when-opening-new-dired-buffer t)
  (dired-dwim-target t))

;; Recent files
(use-package recentf
  :bind ("M-g r" . recentf)
  :custom
  (recentf-max-saved-items 100)
  (recentf-max-menu-items 10)
  :hook
  (after-init-hook . recentf-mode))

;; Compile
(use-package compile
  :bind
  ("<f12>" . compile)
  :custom
  (compilation-always-kill t)
  (compilation-scroll-output t)
  (ansi-color-for-compilation-mode t)
  :hook
  (compilation-filter-hook . ansi-color-compilation-filter))

;; Calendar
(use-package calendar
  :custom
  (calendar-week-start-day 1)
  (calendar-date-style 'european))

;; Autorevert
(use-package autorevert
  :init
  (global-auto-revert-mode 1))

;; Proced
(use-package proced
  :custom
  (proced-enable-color-flag t)
  (proced-tree-flag t)
  (proced-auto-update-flag nil)
  (proced-descent t)
  (proced-filter 'user))

;; Flymake
(use-package flymake
  :bind
  (:map flymake-mode-map
        ("M-9" . flymake-show-buffer-diagnostics)
        ("M-8" . flymake-goto-next-error)
        ("M-7" . flymake-goto-prev-error)))

;; Eldoc
(use-package eldoc
  :custom
  (eldoc-echo-area-use-multiline-p nil)
  (eldoc-echo-area-prefer-doc-buffer t)
  (eldoc-documentation-strategy 'eldoc-documentation-compose)
  :init
  (global-eldoc-mode))

;; Treesitter
(use-package treesit
  :custom
  (treesit-enabled-modes t))

;; Eglot
(use-package eglot
  :custom
  (eglot-autoshutdown t)
  (eglot-documentation-renderer 'markdown-ts-view-mode)
  (eglot-code-action-indications nil)
  :hook
  (c-mode-hook . eglot-ensure)
  (c-ts-mode-hook . eglot-ensure))

;; Whitespace
(use-package whitespace
  :hook
  (before-save-hook . whitespace-cleanup))

;; Eshell
(use-package eshell
  :custom
  (eshell-banner-message "")
  :bind
  ("C-c e" . eshell))

;; Corfu
(use-package corfu
  :ensure t
  :init
  (setq corfu-auto t
        corfu-auto-delay 0.2
        corfu-auto-trigger "."
        corfu-quit-no-match 'separator)
  (global-corfu-mode))

;; Magit
(use-package magit
  :ensure t
  :bind
  ("C-c g" . magit))

;; Electric pair
(use-package electric-pair
  :hook
  (after-init-hook . electric-pair-mode))

;; Org
(use-package org
  :custom
  (org-edit-src-persistent-message)
  (org-hide-emphasis-markers nil)
  (org-hide-macro-markers nil)
  (org-hide-leading-stars nil)
  (org-cycle-separator-lines 0)
  (org-return-follows-link t)
  (org-structure-template-alist
   '(("s" . "src")
     ("e" . "src emacs-lisp")
     ("E" . "src emacs-lisp :results value code :lexical t")
     ("t" . "src emacs-lisp :tangle FILENAME")
     ("T" . "src emacs-lisp :tangle FILENAME :mkdirp yes")
     ("x" . "example")
     ("X" . "export")
     ("q" . "quote")))
  :bind
  (:map org-mode-map
        ("M-." . org-edit-special)
        :map org-src-mode-map
        ("M-," . org-edit-src-exit)))

;; Theme
(use-package ef-themes
  :ensure t
  :init
  (ef-themes-take-over-modus-themes-mode 1)
  :bind
  ("<f1>" . 'modus-themes-toggle)
  :config
  (setq modus-themes-mixed-fonts t)
  (setq modus-themes-italic-constructs t)
  (modus-themes-load-theme 'ef-cyprus))

;; Persist minibuffer history
(use-package savehist
  :init
  (savehist-mode))

;; Minibuffer completion
(use-package vertico
  :ensure t
  :custom
  (vertico-scroll-margin 0)
  :init
  (vertico-mode))

;; Minibuffer completion style
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil)
  (completion-pcm-leading-wildcard t))

;; Minibuffer annotations
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))
