

(print "=============== Start Test ==================")

(print (format "Default Connection Type %S" process-connection-type))

(setq buf (generate-new-buffer "*shell*"))

(defun exec-shell (shell type)
  (condition-case err
      (progn
        (print (format "---------- Shell %s Start %S -----------" shell type))
        (with-current-buffer buf
          (erase-buffer))
        (let ((process-connection-type type))
          (let ((proc (start-process shell buf shell)))
            (sleep-for 5)
            (process-send-string proc "echo 1\n")
            (sleep-for 5)
            (process-send-eof proc)
            (sleep-for 5)
            (delete-process proc))
          (with-current-buffer buf
            (print (buffer-string))))
        (print "---------- Shell Finish -----------"))
    (error
     (message "Error: %s" err))))

(exec-shell "sh" nil)
(exec-shell "sh" t)
(exec-shell "sh" 'pty)

;; (exec-shell "bash" nil)
;; (exec-shell "bash" t)
;; (exec-shell "bash" 'pty)

;; (exec-shell "zsh" nil)
;; (exec-shell "zsh" t)
;; (exec-shell "zsh" 'pty)

(defun exec-sqlite (type)
  (condition-case err
      (progn
        (print (format "---------- Sqlite3 Unit Start %S -----------" type))
        (with-current-buffer buf
          (erase-buffer))
        (let ((process-connection-type type))
          (let ((proc (start-process "sqilte" buf "sqlite3")))
            (sleep-for 5)
            (process-send-string proc "select 1;\n")
            (sleep-for 5)
            (process-send-string proc ".quit\n")
            (sleep-for 5)
            (delete-process proc))
          (with-current-buffer buf
            (print (buffer-string))))
        (print "---------- Sqlite3 Unit Finish -----------"))
    (error
     (message "Error: %s" err))))

(exec-sqlite nil)
(exec-sqlite t)
(exec-sqlite 'pty)


(print "=============== Finish Test ==================")
