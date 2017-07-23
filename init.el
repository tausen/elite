
;; Needed for packages installed via M-x package-install to work
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                           ("marmalade" . "http://marmalade-repo.org/packages/")
                           ("melpa" . "http://melpa.milkbox.net/packages/")))
  )

(progn
  (ido-mode t)
  (setq ido-enable-flex-matching t)

  (menu-bar-mode -1)
  (when (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
  (when (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

  (autoload 'zap-up-to-char "misc"
    "Kill up to, but not including ARGth occurrence of CHAR." t)

  (require 'uniquify)
  (setq uniquify-buffer-name-style 'forward)

  (require 'saveplace)
  (setq-default save-place t)

  (global-set-key (kbd "M-/") 'hippie-expand)
  (global-set-key (kbd "C-x C-b") 'ibuffer)
  (global-set-key (kbd "M-z") 'zap-up-to-char)

  (global-set-key (kbd "C-s") 'isearch-forward-regexp)
  (global-set-key (kbd "C-r") 'isearch-backward-regexp)
  (global-set-key (kbd "C-M-s") 'isearch-forward)
  (global-set-key (kbd "C-M-r") 'isearch-backward)

  (show-paren-mode 1)
  (setq-default indent-tabs-mode t)
  (setq x-select-enable-clipboard t
        x-select-enable-primary t
        save-interprogram-paste-before-kill t
        apropos-do-all t
        mouse-yank-at-point t
        require-final-newline t
        visible-bell t
        ediff-window-setup-function 'ediff-setup-windows-plain
        save-place-file (concat user-emacs-directory "places")
        backup-directory-alist `(("." . ,(concat user-emacs-directory
                                                 "backups")))))

(provide 'better-defaults)


;; Dont split words across lines with exceptions
(global-visual-line-mode t)
;;(global-visual-line-mode nil)
;; (setq visual-disabled-modes-list
;;       '(term-mode eshell-mode wl-summary-mode compilation-mode erc-mode magit-status-mode))
;; (defun visual-line-on ()
;;   (unless (or (minibufferp) (member major-mode visual-disabled-modes-list))
;;     (visual-line-mode 1)))

;; Set the fill column 
(setq-default fill-column 72)

(column-number-mode)

; linum spacing
;(setq linum-format "%d ")
;If you want a solid line separator, try something like this:
;(setq linum-format “%4d \u2502 “)

;; highlight current line
;; (global-hl-line-mode 1)
;; (set-face-background 'hl-line "gray10")

;; bind return to newline and indent (turn on autoindentation)
(define-key global-map (kbd "RET") 'newline-and-indent)

;; ===== Set standard indent ====
(setq standard-indent 8)
(setq-default tab-width 8)

;; ===== Turn off tab character =====
;; Emacs normally uses both tabs and spaces to indent lines. If you
;; prefer, all indentation can be made from spaces only. To request this,
;; set `indent-tabs-mode' to `nil'. This is a per-buffer variable;
;; altering the variable affects only the current buffer, but it can be
;; disabled for all buffers.
;; Use (setq ...) to set value locally to a buffer
;; Use (setq-default ...) to set value globally 
(setq-default indent-tabs-mode t)

;; set automated backups dir
; Enable backup files.
;(setq make-backup-files t)
; Enable versioning with default values (keep five last versions, I think!)
;(setq version-control t)
; Save all backup file in this directory.
;(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/")))
(setq backup-directory-alist `(("." . "~/.emacs_backups")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; ############################################
; From:
; http://paradox1x.org/2010/06/making-emacs-wi/
;; visible bell
(setq visible-bell nil)
;; allow selection deletion
(delete-selection-mode t)
;; make sure delete key is delete key
(global-set-key [delete] 'delete-char)
;; turn off the menu bar
(menu-bar-mode 0)
;; have emacs scroll line-by-line
(setq scroll-step 1)
;; ;; set color-theme
;; ;(color-theme-zenburn)
(load-theme 'tango-dark t)
(defun my-zoom (n)
"Increase or decrease font size based upon argument"
(set-face-attribute 'default (selected-frame) :height
(+ (face-attribute 'default :height) (* (if (> n 0) 1 -1) 10))))
(global-set-key (kbd "C-c C-z C-+")      '(lambda nil (interactive) (my-zoom 1)))
(global-set-key (kbd "C-c C-z C--")      '(lambda nil (interactive) (my-zoom -1)))
;; (global-set-key (kbd "C-+")      '(lambda nil (interactive) (my-zoom 1)))
;; (global-set-key [C-kp-add]       '(lambda nil (interactive) (my-zoom 1)))
;; (global-set-key (kbd "C--")      '(lambda nil (interactive) (my-zoom -1)))
;; (global-set-key [C-kp-subtract]  '(lambda nil (interactive) (my-zoom -1)))
;; ############################################

;; set mouse scroll to line by line
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
;; nicer mouse scroll
(setq mouse-wheel-progressive-speed nil)
;; smooth scrolling
;(require 'smooth-scrolling)
;(require 'smooth-scroll)
;(smooth-scroll-mode t)
;; dont scroll as much with M-v and C-v
(setq next-screen-context-lines 10)
;; nicer scrolling behaviour
;(setq scroll-step 1)
;(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)

(show-paren-mode t)

;; truncate lines 
(setq-default truncate-lines t) 
(global-set-key (kbd "<f6>") 'toggle-truncate-lines) ; bind f6 to toggle
(add-hook 'latex-mode-hook (lambda () (setq truncate-lines nil))) ; dont truncate in latex mode
(add-hook 'compilation-mode-hook (lambda () (setq truncate-lines t))) ; please truncate in compilation mode
(add-hook 'buffer-menu-mode-hook (lambda () (setq truncate-lines t))) ; please truncate in buffer menu
(add-hook 'c-mode-hook (lambda () (setq truncate-lines t))) ; please truncate in c-mode
(add-hook 'lisp-mode-hook (lambda () (setq truncate-lines t))) ; please truncate in lisp-mode
(add-hook 'term-mode-hook (lambda () (setq truncate-lines t))) ; truncate in ansi-term and similar
(add-hook 'diff-mode-hook (lambda () (setq truncate-lines t))) ; truncate lines in diff mode
(add-hook 'ibuffer-mode-hook (lambda () (setq truncate-lines t))) ; truncate lines in ibuffer mode
(add-hook 'proced-mode-hook (lambda () (setq truncate-lines t))) ; truncate lines in proced mode

;; Automatically enable auto fill mode in text modes
;; http://www.emacswiki.org/emacs/AutoFillMode
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; auto scroll compilation window
(setq compilation-auto-scroll t)
(setq compilation-scroll-output t)

;; Align with spaces only
;; (defadvice align-regexp (around align-regexp-with-spaces)
;;   "Never use tabs for alignment."
;;   (let ((indent-tabs-mode nil))
;;     ad-do-it))
;; (ad-activate 'align-regexp)

;; Allow copying to system clipboard
(setq x-select-enable-clipboard t)

;; Disable blinking cursor
(blink-cursor-mode 0)

; y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; Automatically update buffers if files are changed
;(global-auto-revert-mode t)

(global-set-key (kbd "C-x C-o") 'other-window)

(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))
(global-set-key (kbd "M-'") 'comment-or-uncomment-region-or-line)

;; delete pair of parens, ..
(global-set-key (kbd "C-x p") 'delete-pair)

;; go to next/previous match (errors, grep, ..)
(global-set-key (kbd "C-x C-n") 'next-error)
(global-set-key (kbd "C-x C-p") 'previous-error)


(add-to-list 'load-path "~/.elite/")
(require 'god-mode)
(global-set-key (kbd "C-x C-1") 'delete-other-windows)
(global-set-key (kbd "C-x C-2") 'split-window-below)
(global-set-key (kbd "C-x C-3") 'split-window-right)
(global-set-key (kbd "C-x C-0") 'delete-window)
(global-set-key (kbd "C-x C-{") 'shrink-window-horizontally)
(global-set-key (kbd "C-x C-}") 'enlarge-window-horizontally)
(global-set-key (kbd "C-x C-[") 'shrink-window)
(global-set-key (kbd "C-x C-]") 'enlarge-window)
(global-set-key (kbd "C-x C-5 C-0") 'delete-frame)
(global-set-key (kbd "C-x C-#") 'server-edit)
(define-key god-local-mode-map (kbd "z") 'repeat)
(define-key god-local-mode-map (kbd "i") 'god-or-newline)

;; Bind ALL the keys
(global-set-key (kbd "<escape>") 'god-or-newline)
(global-set-key (kbd "<RET>") 'god-or-newline) ;; really bad when pasting into nowindow
(global-set-key (kbd "<home>") 'god-or-newline)
(global-set-key (kbd "<f12>") 'god-or-newline)
;; (add-hook 'LaTeX-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-mode-all)))
;; (add-hook 'org-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-mode-all)))
;; (add-hook 'js2-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-mode-all)))
;; (add-hook 'python-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-mode-all)))
;; (add-hook 'c-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-mode-all)))
;; (add-hook 'emacs-lisp-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-mode-all)))
;; (add-hook 'web-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-mode-all)))
;; (add-hook 'css-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-mode-all)))
;; (add-hook 'markdown-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-mode-all)))
;; (add-hook 'inferior-python-mode-hook (lambda () (local-set-key (kbd "<f12>") 'god-mode-all)))

;; make god-mode work in vhdl-mode
(add-hook 'vhdl-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-mode-all)))
(add-hook 'vhdl-mode-hook (lambda () (define-key god-local-mode-map (kbd "<SPC>") 'set-mark-command)))

(add-to-list 'god-exempt-major-modes 'term-mode)
(setq god-exempt-predicates '(god-exempt-mode-p god-view-mode-p god-special-mode-p))

;; indicate whether god-mode is on with blue mode-line background
;; always works (if not in limited colors term..)
(defun c/god-mode-update-cursor ()
  (cond (god-local-mode (progn (set-face-background 'mode-line "deep sky blue")))
        (t (progn (set-face-background 'mode-line "gray80")))))
(add-hook 'god-mode-enabled-hook 'c/god-mode-update-cursor)
(add-hook 'god-mode-disabled-hook 'c/god-mode-update-cursor)

(set-face-foreground 'minibuffer-prompt "gray50")
(set-face-background 'region "yellow")

;; toggle RET between god-mode-all and newline with bind-ret-god
(setq god-bound-to-ret t)

(defun god-or-newline ()
  (interactive)
  (if god-bound-to-ret (god-mode-all) (newline)))

(defun bind-ret-god ()
  (cond

   (god-bound-to-ret (global-set-key (kbd "<RET>") 'newline)
                     (setq god-bound-to-ret nil)
                     (message "RET bound to newline") )

   (t (global-set-key (kbd "<RET>") 'god-or-newline)
      (setq god-bound-to-ret t)
      (message "RET bound to god-mode-all") )
   
   ))

(global-set-key (kbd "<f7>") (lambda () (interactive) (bind-ret-god)))

;; Some scrolling hotkeys
(global-set-key (kbd "M-p") (lambda () (interactive) (scroll-down 5)))
(global-set-key (kbd "M-n") (lambda () (interactive) (scroll-up 5)))
(global-set-key (kbd "C-s-p") (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "C-s-n") (lambda () (interactive) (next-line 5)))
;; (global-set-key (kbd "s-p") (lambda () (interactive) (scroll-previous-line 1)))
;; (global-set-key (kbd "s-n") (lambda () (interactive) (scroll-next-line 1)))
(global-set-key (kbd "M-s-p") (lambda () (interactive) (scroll-previous-line 5)))
(global-set-key (kbd "M-s-n") (lambda () (interactive) (scroll-next-line 5)))

(electric-indent-mode -1)

(message "All done!")
