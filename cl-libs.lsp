(in-package :cl-user)
(quicklisp:quickload "usocket")
(quicklisp:quickload "sb-concurrency")
(defun is-streaming-socket (socket)
  (eql 'usocket:socket
       (sb-mop:slot-definition-name
	(first (sb-mop:class-slots
		(find-class 'usocket:stream-server-usocket))))))
