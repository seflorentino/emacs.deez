(use-package emacs
  :config

  ;; Use treesitter modes
  (setq major-mode-remap-alist
	'((yaml-mode . yaml-ts-mode)
	  (bash-mode . bash-ts-mode)
	  (js2-mode . js-ts-mode)
	  (typescript-mode . typescript-ts-mode)
	  (json-mode . js-ts-mode)
	  (typescript-mode . typescript-ts-mode)
	  (json-mode . json-ts-mode)
	  (css-mode . css-ts-mode)
	  (python-mode . python-ts-mode)
	  (rust-mode . rust-ts-mode)))
  :hook
  ((prog-mode . electric-pair-mode)))


;; Common modes
(use-package markdown-mode :hook ((markdown-mode . visual-line-mode)))
(use-package yaml-mode :ensure t)
(use-package json-mode :ensure t)

;; Eglot
(use-package eglot
  :hook
  (((python-mode rust-mode) . eglot))

  :custom
  (eglot-send-changes-idle-time 0.1)
  (eglot-extend-to-xref t)

  :config
  (fset #'jsonrpc--log-event #'ignore) ; bedrock: don't log every event
  )
