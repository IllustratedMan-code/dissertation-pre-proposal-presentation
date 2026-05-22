
(define my-process
  (process!
   script : #<<"""
    mkdir {{out}}
    echo 'hi world' > {{out}}/hi.txt
   """
 ))


(test!
 my-process ;; what process to test
 "./hi.txt" ;; relative path of file to test
 "hi world") ;; check contents of file
