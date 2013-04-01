;; We need mouse wheel!
(setq scroll-step 1)

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

;; Forcing show-paren-mode
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;; Misc setting
(global-hl-line-mode 1)
(add-to-list 'default-frame-alist '(cursor-color . "palegoldenrod"))

;; Custom font, trick from https://github.com/overtone/emacs-live/issues/25
(add-to-list 'default-frame-alist '(font . "PragmataPro 14"))