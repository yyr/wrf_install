;;; Directory Local Variables
;;; See Info node `(emacs) Directory Variables' for more information.

((fundamental-mode . ((eval . (when (and (buffer-file-name)
                                         (file-regular-p (buffer-file-name))
                                         (string-match-p "\\.env$" (buffer-file-name)))
                                (sh-mode))))))
