(when (< emacs-major-version 29)
  (error "Current Emacs version %s < 29" emacs-major-version))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Package Repositories
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; MELPA
(with-eval-after-load 'package
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Customization
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Default mode for *scratch* buffer
(setopt initial-major-mode 'fundamental-mode)
;; Consider period followed by one space or by a newline as the end of a sentence
(setopt sentence-end-double-space nil)

;; Reverts any buffer associated with a file when the file changes on disk
(global-auto-revert-mode)

;; Save minibuffer history to 'savehist-file' periodically and when existing
(savehist-mode)

;; Save backups
(let ((backup-directory (expand-file-name "backups/" user-emacs-directory)))
  (unless (file-exists-p backup-directory)
    (make-directory backup-directory))
  (setq backup-directory-alist `(("." . ,backup-directory))))

(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; which-key: displays the key bindings following your currently entered
;; incomplete command (a prefix) in a popup
(use-package which-key :ensure t :config (which-key-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; UI
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Display column number
(setopt column-number-mode t)
;; Mark fringe if buffer is scrollable
(setopt indicate-buffer-boundaries 'left)

;; Scrolling
(setopt scroll-margin 2)
(setopt scroll-step 1)
(setopt scroll-conservatively 10000)
(setopt scroll-preserve-screen-position 1)

;; Horizontal wheel scrolling
(setopt mouse-wheel-tilt-scroll t)
(setopt mouse-wheel-flip-direction t)

;; Stop cursor blinks after X blinks
(setopt blink-cursor-blinks 3)
(blink-cursor-mode t)

;; Smooth scrolling
(pixel-scroll-precision-mode)

;; Line numbers
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
;; Line wrapping when working with text
(add-hook 'text-mode-hook 'visual-line-mode)
;; Highlight current line
(let ((hl-line-hooks '(text-mode-hook prog-mode-hook)))
  (mapc (lambda (hook) (add-hook hook 'hl-line-mode)) hl-line-hooks))

;; Hide tab bar when it has only one tab, and show it again ince more tabs are
;; created.
(setopt tab-bar-show 1)

;; Display time
(setopt display-time-interval 1)
(display-time-mode)

;; Theme
(defun my/load-themes (themes)
  (let ((theme-loaded nil))
    (dolist (theme themes)
      (when (and (not theme-loaded)
		 (member theme (custom-available-themes)))
	(load-theme theme t)
	(setq theme-loaded t)))))
(use-package emacs :config (my/load-themes '(modus-vivendi-tinted modus-vivendi)))

;; Font
(defun my/font-exists (font)
  (if (null (x-list-fonts font)) nil t))
(defun my/try-load-fonts (fonts)
  (let ((font-loaded nil))
    (dolist (font fonts)
      (when (and (not font-loaded)
		 (my/font-exists font))
	(set-frame-font font nil t)))))
(my/try-load-fonts '("IBM Plex Mono" "Hack" "Source Code Pro"))

(setopt initial-frame-alist
	'((top . 1) (left . 1) (width . 185) (height . 56)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; OS Integration
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Ensure that Emacs kill operations do not irrevocably overwrite existing
;; clipboard text
(setopt save-interprogram-paste-before-kill t)

;; Paste/yank into cursor/point location and not mouse pointer location
(setopt mouse-yank-at-point t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Extras
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(load-file (expand-file-name "extras/base.el" user-emacs-directory))
(load-file (expand-file-name "extras/dev.el" user-emacs-directory))

