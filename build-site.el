;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)

;; Keep publishing state inside the workspace so local and CI builds are repeatable.
(setq org-publish-timestamp-directory
      (file-name-as-directory (expand-file-name "./.org-timestamps")))

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head (concat
                     "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />"
                     "<link rel=\"stylesheet\" href=\"/assets/css/site.css\" />"))

;; Shared header for every exported page; page titles remain in metadata.
(setq org-html-preamble
      (concat
       "<header class=\"site-header\">"
       "<a class=\"site-brand\" href=\"/\">Cupppa Lab</a>"
       "<nav class=\"site-nav\" aria-label=\"主导航\">"
       "<a href=\"/\">首页</a>"
       "<a href=\"/posts/index.html\">文章</a>"
       "<a href=\"/categories/index.html\">分类</a>"
       "<a href=\"/about.html\">关于</a>"
       "</nav></header>"))

;; Define the publishing projects
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :recursive t
             :base-directory "./org"
             :publishing-directory "./public_html"
             :publishing-function 'org-html-publish-to-html
             :with-title nil            ;; Body headings identify the page
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc nil              ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil)      ;; Don't include time stamp in file
       (list "org-site:assets"
             :recursive t
             :base-directory "./org/assets"
             :publishing-directory "./public_html/assets"
             :base-extension "css\\|js\\|png\\|jpg\\|jpeg\\|gif\\|svg\\|webp\\|pdf"
             :publishing-function 'org-publish-attachment)
       (list "org-site"
             :components '("org-site:main" "org-site:assets"))))

;; Generate the site output
(org-publish-project "org-site" t)

(message "Build complete!")
