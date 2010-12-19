;;; qooxdoo.el --- helper functions for working with qooxdoo

;; Copyright (C) 2010  Jeremiah Dodds

;; Author: Jeremiah Dodds <jeremiah.dodds@gmail.com>
;; Keywords: convenience, docs

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; The cleanest way I've found to load this so for is eproject, see
;; <https://github.com/jrockway/eproject>. Something like:

;; (require 'eproject)
;;
;; (define-project-type qooxdoo (generic)
;;   (and (look-for "generator.py")
;;        (look-for "Manifest.json")
;;        (look-for "config.json"))
;;   :relevant-files ("\\.js$"))
;;
;; (defun my-qooxdoo-project-file-visit-hook ()
;;   (require 'qooxdoo)
;;   (with-current-buffer (qooxdoo-minor-mode)))
;;
;; (add-hook 'qooxdoo-project-file-visit-hook 'my-qooxdoo-project-file-visit-hook)

;; in your .emacs should do just fine.
;;; Code:
(require 'thingatpt)

;;;###autoload
(defgroup qooxdoo nil
  "Convenience functions for working with qooxdoo apps"
  :prefix "qooxdoo-"
  :group 'convenience)

(defcustom qooxdoo-api-url "http://demo.qooxdoo.org/current/apiviewer/#"
  "URL where the qooxdoo api lives"
  :type 'string
  :group 'qooxdoo)

(defun qooxdoo-bounds-of-qooxdoo-at-point ()
  "Return the (possibly chained) class heirarchy at point"
  (save-excursion
    (skip-chars-backward "$0-9a-zA-z\._")
    (if (looking-at "[$0-9a-zA-z._]+")
        (cons (point)
              (match-end 0))
      nil)))

(put 'qooxdoo 'bounds-of-thing-at-point
     'qooxdoo-bounds-of-qooxdoo-at-point)

(defun qooxdoo-search-api ()
  "Bring up the qooxdoo docs for the function at point"
  (interactive)
  (browse-url (concat qooxdoo-api-url (thing-at-point 'qooxdoo))))

(provide 'qooxdoo)
;;; qooxdoo.el ends here
