(add-hook 'find-file-hook
	  (lambda ()
	    (when (string= (file-name-base buffer-file-name) "COMMIT_EDITMSG")
	      (auto-fill-mode +1))))

;(setq diff-font-lock-syntax nil)

(setq column-number-mode t)

(defun update-diff-colors ()
  "update the colors for diff faces"
  (set-face-attribute 'diff-added nil
                      :foreground "green" :background "black")
  (set-face-attribute 'diff-removed nil
                      :foreground "red" :background "black")
  (set-face-attribute 'diff-changed nil
                      :foreground "white" :background "purple"))
(eval-after-load "diff-mode"
  '(update-diff-colors))

