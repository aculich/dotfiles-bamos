;; (when (eq system-type 'darwin)
;;   (progn
;;     (defun copy-from-osx () (let ((tramp-mode nil) (default-directory "~"))
;;                               (shell-command-to-string "pbpaste")))
;;     (defun paste-to-osx (text &optional push)
;;       (let ((process-connection-type nil))
;;         (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;;           (process-send-string proc text)
;;           (process-send-eof proc))))

;;     (setq interprogram-cut-function 'paste-to-osx)
;;     (setq interprogram-paste-function 'copy-from-osx)))
