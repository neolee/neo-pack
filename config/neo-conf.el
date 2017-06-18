;; We need mouse wheel!
(setq scroll-step 1)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)

;; We hate the toolbar
(tool-bar-mode 0)

;; Some tweaks
(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(mouse-avoidance-mode 'cat-and-mouse)

(add-to-list 'default-frame-alist '(height . 54))
(add-to-list 'default-frame-alist '(width . 210))

;; I hate auto save and auto backup files scattered all over the file system
;; so we turn them off...
; (setq make-backup-files nil)
; (setq auto-save-default nil)
;; ... or make them all in ONE place
(defvar autosave-dir "~/.live-packs/.auto-save-files/")

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat autosave-dir
    (if buffer-file-name
      (concat "#" (file-name-nondirectory buffer-file-name) "#")
      (expand-file-name
        (concat "#%" (buffer-name) "#")))))

;; backup files (ie foo~) - backup-directory-alist list contains regexp=>directory mappings
;; filenames matching a regexp are backed up in the corresponding directory
(defvar backup-dir "~/.live-packs/.backup-files/")
(setq backup-directory-alist (list (cons "." backup-dir)))

;; Disable abbrev save to prevent weird annoying
(setq abbrev-file-name "~/.live-packs/abbrev_defs")
(setq save-abbrevs nil)

;; Default encoding for Emacs in terminal
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Make any instance of Emacs know my PATH well
(setenv "PATH" (shell-command-to-string "echo $PATH"))

;; Add MELPA Stable packages
(require 'package)
(add-to-list 'package-archives
  '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

;; Disable Emacs Live's zoning if any trouble
; (setq live-disable-zone t)

;; Misc setting
(global-hl-line-mode 1)
(add-to-list 'default-frame-alist '(cursor-color . "palegoldenrod"))

;; Custom font, trick from https://github.com/overtone/emacs-live/issues/25
(add-to-list 'default-frame-alist '(font . "PragmataPro 14"))

;; Turn off CIDER help banner
(setq cider-repl-display-help-banner nil)

;; Auto-complete for nREPL (ac-nrepl)
; (require 'ac-nrepl)
; (add-hook 'cider-mode-hook 'ac-nrepl-setup)
; (add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
; (add-to-list 'ac-modes 'cider-mode)
; (add-to-list 'ac-modes 'cider-repl-mode)

;; Auto-complete for CIDER (ac-cider)
(require 'ac-cider)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

;; Rainbow mode for nREPL as well
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

;; Clojure indentation config for compojure
(require 'clojure-mode)

(define-clojure-indent
  (defroutes 'defun)
  (GET 2)
  (POST 2)
  (PUT 2)
  (DELETE 2)
  (HEAD 2)
  (ANY 2)
  (context 2))