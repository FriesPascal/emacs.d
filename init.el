;;;;
;;;; ---------------------- Packages --------------------------
;;;;

;; Bootstrap straight.el package manager
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; general packages
(use-package company :straight t)
(use-package nerd-icons :straight t)
(use-package doom-modeline :straight t)
(use-package evil :straight t)
(use-package syndicate :straight t)
(use-package flycheck :straight t)
(use-package hasklig-mode :straight t)
(use-package ivy :straight t)
(use-package magit :straight t)
(use-package material-theme :straight t)
(use-package spacemacs-theme :straight t)
(use-package zenburn-theme :straight t)

;; language support
(use-package dockerfile-mode :straight t)
(use-package go-mode :straight t)
(use-package json-mode :straight t)
(use-package markdown-mode :straight t)
(use-package rust-mode :straight t)
(use-package terraform-mode :straight t)
(use-package yaml-mode :straight t)

;; language server
(use-package lsp-mode :straight t)
(use-package lsp-ui :straight t)
(use-package lsp-treemacs :straight t)
(use-package lsp-ivy :straight t)


;;;;
;;;; ----------------------- Theme ----------------------------
;;;;

;; no menu-/ toolbar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; change theme
(load-theme 'material t)
(doom-modeline-mode 1)

;; use hasklig font w/ ligatures
(set-face-attribute 'default nil
                    :family "Hasklig"
                    :height 105
                    :weight 'normal
                    :width 'normal)
(define-global-minor-mode global-hasklig-mode hasklig-mode
  (lambda () (hasklig-mode 1)))
(if (display-graphic-p) (global-hasklig-mode 1))

;; show fill column indicator and line numbers
(setq-default fill-column 80)
(global-display-fill-column-indicator-mode 1)
(setq-default display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

;; custom function to change font size globally
(defun set-default-font-size (factor)
  "Set global default font size."
  (interactive "sWhich size to set to (in 1/10th pt)? ")
  (set-face-attribute 'default nil :height (string-to-number factor)))

(global-set-key (kbd "C-x C-ß") 'set-default-font-size)


;;;;
;;;; ---------------------- General ---------------------------
;;;;

;; use spaces for tabs
(setq-default indent-tabs-mode nil)
(setq-default electric-indent-inhibit t)

;; use centralized backups dir
(setq backup-directory-alist (list (cons "." (expand-file-name "backups" user-emacs-directory))))

;; no splash screen
(setq inhibit-splash-screen t)

;; custom keybindings for terminals
(defun dumb-term nil
    "Start a (shell) terminal in a new buffer."
  (interactive)
  (shell (generate-new-buffer-name "dumb term")))

(global-set-key (kbd "C-c d") 'dumb-term)

(defun smart-term nil
    "Start a (smart) terminal in a new buffer."
  (interactive)
  (ansi-term "/bin/bash" (generate-new-buffer-name "smart term")))

(global-set-key (kbd "C-c s") 'smart-term)

;;;;
;;;; --------------------- Mode Specific -----------------------
;;;;

;; company
(add-hook 'after-init-hook 'global-company-mode)

;; evil
(evil-mode 1)
(evil-set-initial-state 'shell-mode 'emacs)
(evil-set-initial-state 'term-mode 'emacs)
(evil-set-initial-state 'dired-mode 'emacs)

;; ivy
(ivy-mode 1)

;; lsp
(setq lsp-rust-server 'rust-analyzer)
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 2048 2048))
(setq lsp-keymap-prefix "C-c l")
(setq lsp-eldoc-enable-hover nil)
(setq lsp-signature-auto-activate t)
(setq lsp-signature-render-documentation-activate t)
(setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
(setq lsp-modeline-code-actions-segments '(count name))
(setq lsp-ui-doc-enable t)
(setq lsp-ui-doc-show-with-cursor t)
(setq lsp-ui-doc-show-with-mouse nil)
(setq lsp-ui-doc-enable t)
(setq lsp-ui-lens-enable nil)
(setq lsp-ui-sideline-enable t)
(setq lsp-ui-sideline-show-code-actions nil)
(setq lsp-ui-sideline-show-diagnostics t)
(setq lsp-ui-sideline-show-hover t)
(lsp-treemacs-sync-mode 1)
(add-hook 'rust-mode-hook (lambda () (lsp 1)))
(add-hook 'go-mode-hook (lambda () (lsp 1)))

;; treemacs
(add-hook 'treemacs-mode-hook (lambda () (display-line-numbers-mode -1)))

;; org
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-startup-indented t)
(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook (lambda () (local-set-key (kbd "C-<tab>") 'org-cycle)))
(setq org-todo-keywords '((sequence "Backlog(b)" "In Progress(p!)" "|" "Waiting(w@/!)" "Under Review(r!)" "Done(d!)")))


(setq org-export-backends '(ascii html icalendar latex md odt))


;;;;
;;;; ---------------------- No touchy --------------------------
;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
