;; (defconst user-init-dir (cond
;;   ((boundp 'user-emacs-directory) user-emacs-directory)
;;   ((boundp 'user-init-directory) user-init-directory)
;;   (t "~/.emacs.d/")))


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defun load-user-file (file) (interactive "f")
  "Load a file in current user's configuration directory"
  ;; (load-file (expand-file-name file user-init-dir)))
  (load-file (expand-file-name file "~/.emacs.d")))

(defun my-system-type-is-darwin ()
  "Return true if system is darwin-based (Mac OS X)"
  (string-equal system-type "darwin")
  )

; Hack to use GNU tar on OSX for quelpa:
; https://github.com/quelpa/quelpa/issues/221#issuecomment-882123183
(setenv "PATH" "/usr/local/opt/gnu-tar/libexec/gnubin:$PATH" t)

(load-user-file "packages.el")

; (load-user-file "clipboard.el")
(load-user-file "funcs.el")
(load-user-file "mail.el")

(load-user-file "init-auctex.el")
(load-user-file "init-evil.el")
(load-user-file "init-org.el")
(load-user-file "init-helm.el")
(load-user-file "init-web-mode.el")
(load-user-file "init-spell.el")

(load-theme 'zenburn t)
(require 'color-theme-modern)
(load-theme 'charcoal-black t t)
(enable-theme 'charcoal-black)

(require 'magit)
(global-set-key (kbd "C-x C-g") 'magit-status)
(setq magit-push-always-verify nil
      magit-last-seen-setup-instructions "1.4.0")

(setq ring-bell-function 'ignore)

(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] '(lambda () (interactive) (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda () (interactive) (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
)

(add-hook 'find-file-hook (lambda () (linum-mode 0))) ; Line numbers.
(set-face-foreground 'minibuffer-prompt "white") ; White miniprompt.
(fset 'yes-or-no-p 'y-or-n-p) ; yes/no -> y/n
(setq vc-follow-symlinks t) ; Always follow symlinks.
;; (add-hook 'emacs-startup-hook  'delete-other-windows)
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(show-paren-mode 1)
(setq show-paren-delay 0)

(setq shell-prompt-pattern ".*» *")
;; (setq dired-use-ls-dired nil)

(setq show-trailing-whitespace t)
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
(defun save-buffer-without-dtw () ; http://stackoverflow.com/questions/14913398
  (interactive)
  (let ((b (current-buffer)))
    (with-temp-buffer
      (let ((before-save-hook (remove 'delete-trailing-whitespace before-save-hook)))
        (with-current-buffer b
          (let ((before-save-hook
                 (remove 'delete-trailing-whitespace before-save-hook)))
            (save-buffer)))))))

(require 'saveplace)
(setq save-place-file (concat user-emacs-directory "saveplace.el") )
(setq save-place t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq mode-line-format nil)

(transient-mark-mode 1)

; Re-initialize mouse mode for tmux.
(defun my-terminal-config (&optional frame)
  (if xterm-mouse-mode (xterm-mouse-mode 1)))
(add-hook 'after-make-frame-functions 'my-terminal-config)

(setq compilation-scroll-output 'first-error)

;; default tab width to 2 except for python
(setq indent-tabs-mode nil)
(setq tab-width 4)(setq sh-basic-offset 4)(setq sh-indentation 4)
;; (add-hook 'python-mode-hook (lambda() (
;;   (setq tab-width 4)(setq sh-basic-offset 4)(setq sh-indentation 4))))

(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets/yasnippet-snippets"
        "~/.emacs.d/snippets/yasmate/snippets"
        "~/.emacs.d/snippets/custom"
        "~/repos/yasnippet-lua-torch"
        ))
(yas-global-mode 1)
(global-set-key (kbd "M-/") 'yas-expand)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C-c d") 'redraw-display)

; disable transposes
(global-unset-key (kbd "M-t"))
(global-unset-key (kbd "C-t"))
(global-unset-key (kbd "C-x C-t"))


(setq initial-scratch-message "")

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

(require 'darkroom)
(setq darkroom-margins 0.1)
;; (add-hook 'LaTeX-mode-hook 'darkroom-mode)

;; OSX-specific:
(setenv "PATH" "/usr/local/bin:/Library/TeX/texbin/:$PATH" t)
(setq exec-path (append exec-path '("/Library/TeX/texbin")))

(when (string= system-name "bda-mbp")
    (set-face-attribute 'default (selected-frame) :height 120))
(when (string= system-name "tchaikovsky")
    (set-face-attribute 'default (selected-frame) :height 100))

(server-start)
(put 'downcase-region 'disabled nil)

;; most likely to fail:
(load-user-file "init-ai.el")
(when (file-exists-p "~/.mbsyncrc")
  (load-user-file "init-mu4e.el")
)
