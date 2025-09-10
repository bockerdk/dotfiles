;;; helpers
(defun bocker/toggle-unique-buffer (buffer-name prog &optional prog-args)
  "Toggle a unique buffer specified by BUFFER-NAME.
If the buffer exists, switch to it.
If the buffer is in focus and is the sole window, bury the buffer.
If the buffer is in focus and other windows exist, delete the window.
If the buffer does not exist, create it using PROG and PROG-ARGS."
  (let ((current-window (selected-window)))
    (cond
     ;; The buffer is in focus
     ((string= buffer-name (buffer-name (window-buffer current-window)))
      (if (one-window-p)
          ;; Bury the buffer if it's the only window
          (bury-buffer)
        ;; Delete window if it's not the only one
        (delete-window current-window)))

     ;; If the buffer exists but is not shown, switch to it
     ((get-buffer buffer-name)
      (switch-to-buffer buffer-name))

     ;; If the buffer does not exist, create it
     (t
      (if prog-args
          ;; Call the program with arguments
          (apply prog prog-args)
        ;; Call the program without arguments
        (funcall prog))))))

;;; use-package
(use-package use-package
  :custom
  (use-package-hook-name-suffix nil)
  (use-package-always-ensure nil))

;;; theme
(global-set-key (kbd "<f1>") 'modus-themes-toggle)
(load-theme 'modus-operandi 'NO-CONFIRM)

;;; rebinds
(global-set-key (kbd "C-x k") 'kill-current-buffer)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "C-c s") 'scratch-buffer)
(global-set-key (kbd "C-c I") (lambda () (interactive) (find-file user-init-file)))
(global-set-key (kbd "C-c Q") 'restart-emacs)
(global-set-key (kbd "M-u") 'upcase-dwim)
(global-set-key (kbd "M-l") 'downcase-dwim)
(global-set-key (kbd "M-c") 'capitalize-dwim)

;;; basics
(setq use-short-answers t)
(delete-selection-mode)
(setq next-screen-context-lines 10)
(setq fill-column 78)
(auto-fill-mode)
(setq tab-always-indent 'complete)
(setq-default indent-tabs-mode nil)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq initial-buffer-choice t)
(setq inhibit-startup-echo-area-message "bocker")
(setq initial-scratch-message nil)
(setq-default x-stretch-cursor t)
(blink-cursor-mode -1)
(setq visible-bell nil)
(setq ring-bell-function 'ignore)
(setq custom-file (make-temp-file "emacs-custom-"))
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(add-to-list 'save-some-buffers-action-alist
             (list "d" (lambda (buffer)
                         (diff-buffer-with-file (buffer-file-name buffer)))))

;;; help
(use-package help
  :custom
  (help-window-select t)
  (help-window-keep-selected))

;;; window
(use-package window
  :custom
  (switch-to-buffer-obey-display-actions t)
  (display-buffer-alist
   '(
     ("\\*ansi-term\\*"
      (display-buffer-at-bottom)
      (window-height . 0.50)
      (side . bottom)
      (slot . 0)
      ;; (window-parameters . ((mode-line-format . none)))
      )
     ("\\*eshell\\*"
      (display-buffer-at-bottom)
      (window-height . 0.50)
      (side . bottom)
      (slot . 0)
      ;; (window-parameters . ((mode-line-format . none)))
      )
     ("\\*Proced\\*"
      (display-buffer-in-side-window)
      (window-height . 0.50)
      (side . bottom)
      (slot . 0))
     ("\\*compilation\\*"
      (display-buffer-in-side-window)
      (window-height . 0.50)
      (side . bottom)
      (slot . 1))
     )))

;;; winner
(use-package winner
  :hook
  (after-init-hook . winner-mode))

;;; compile
(use-package compile
  :bind
  ("<f12>" . compile)
  :custom
  (compilation-always-kill t)
  (compilation-scroll-output t)
  (ansi-color-for-compilation-mode t)
  :hook
  (compilation-filter-hook . ansi-color-compilation-filter))

;;; dired
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

;;; calendar
(defvar calendar-week-start-day 1)
(defvar calendar-date-style 'european)

;;; recentf
(use-package recentf
  :bind ("M-g r" . recentf)
  :custom
  (recentf-max-saved-items 100)
  (recentf-max-menu-items 10)
  :hook
  (after-init-hook . recentf-mode))

;;; isearch
(use-package isearch)

;;; imenu
(use-package imenu
  :custom
  (imenu-auto-rescan t)
  (imenu-max-item-length 160))

;;; mode-line
(column-number-mode)

;;; minibuffer
(use-package minibuffer
  :custom
  (completion-styles '(basic partial-completion substring initials))
  (enable-recursive-minibuffers t)
  (completion-show-help nil)
  (completion-show-inline-help t)
  (completions-detailed t)
  (completions-format 'horizontal)
  (completion-ignore-case t)
  (completion-auto-wrap nil)
  (read-buffer-completion-ignore-case t)
  (completion-auto-help 'always)
  (minibuffer-completion-auto-choose nil)
  (completion-auto-select 'second-tab)
  (completions-max-height 10)
  :bind
  (:map minibuffer-mode-map
        ("C-n" . minibuffer-next-completion)
        ("C-p" . minibuffer-previous-completion))
  (:map completion-in-region-mode-map
        ("C-n" . minibuffer-next-completion)
        ("C-p" . minibuffer-previous-completion)))

;;; savehist
(use-package savehist
  :config (savehist-mode 1))

;;; eldoc
(use-package eldoc
  :init (global-eldoc-mode))

;;; flymake
(use-package flymake
  :bind
  (:map flymake-mode-map
        ("M-9" . flymake-show-buffer-diagnostics)
        ("M-8" . flymake-goto-next-error)
        ("M-7" . flymake-goto-prev-error)))

;;; eglot
(use-package eglot
  :custom
  (eglot-autoshutdown t)
  :hook
  (c-mode-hook . eglot-ensure))

;;; electric pair
(use-package electric-pair
  :hook
  (after-init-hook . electric-pair-mode))

;;; paren
(use-package paren
  :hook
  (after-init-hook . show-paren-mode)
  :custom
  (show-paren-delay 0)
  (show-paren-style 'parenthesis)
  (show-paren-context-when-offscreen t))

;;; webjump
(use-package webjump
  :bind
  ("C-x /" . webjump)
  :custom
  (webjump-sites '(("Duck" . [simple-query "www.duckduckgo.com" "www.duckduckgo.com/?q=" ""]))))

;;; whitespace
(use-package whitespace
  :hook
  (before-save-hook . whitespace-cleanup))

;;; proced
(use-package proced
  :custom
  (proced-enable-color-flag t)
  (proced-tree-flag t)
  (proced-auto-update-flag nil)
  (proced-descent t)
  (proced-filter 'user))

;;; ansi-term
(defun bocker/ansi-term ()
  "Toggle ansi-term buffer"
  (interactive)
  (bocker/toggle-unique-buffer "*ansi-term*" 'ansi-term '("/bin/bash")))

(defun bocker/ansi-term-mappings ()
  "Set up key bindings for ansi-term"
  (define-key term-raw-map (kbd "C-c t") 'bocker/ansi-term))

(use-package term
  :hook
  (term-load-hook . bocker/ansi-term-mappings)
  :bind
  ("C-c t" . bocker/ansi-term))

;;; eshell
(defun bocker/eshell ()
  "Toggle eshell buffer"
  (interactive)
  (bocker/toggle-unique-buffer "*eshell*" 'eshell))

(use-package eshell
  :custom
  (eshell-banner-message "")
  :bind
  ("C-c e" . bocker/eshell))

;;; org
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
  ( :map org-mode-map
    ("M-." . org-edit-special)
    :map org-src-mode-map
    ("M-," . org-edit-src-exit)))

;;; denote
(use-package denote
  :ensure t
  :hook (dired-mode . denote-dired-mode)
  :bind
  (("C-c n n" . denote)
   ("C-c n r" . denote-rename-file)
   ("C-c n l" . denote-link)
   ("C-c n b" . denote-backlinks)
   ("C-c n d" . denote-dired)
   ("C-c n g" . denote-grep))
  :config
  (setq denote-directory (expand-file-name "~/Documents/notes/"))

  ;; Automatically rename Denote buffers when opening them so that
  ;; instead of their long file name they have, for example, a literal
  ;; "[D]" followed by the file's title.  Read the doc string of
  ;; `denote-rename-buffer-format' for how to modify this.
  (denote-rename-buffer-mode 1))
