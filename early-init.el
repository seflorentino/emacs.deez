;; Start up settings
(setq gc-cons-threshold 10000000)
(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq native-comp-async-report-warnings-errors 'silent)
(setq inhibit-startup-echo-area-message (user-login-name))
(setq frame-resize-pixelwise t)
(tool-bar-mode -1)
(setq default-frame-alist '((fullscreen . maximized)))
