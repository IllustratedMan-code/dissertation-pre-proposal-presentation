;; main.scm

(define process-1
  (process!
   name : "hello-world"
   script : #<"""
   echo "hello world" > {{out}}
   """
  ))


(output!
 "hello_world.txt" : process-1)
