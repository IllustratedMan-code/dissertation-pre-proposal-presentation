(define data (file! "data.csv"))
(define script1 (file! "clean.py"))
(define script2 (file! "normalize.py"))

(define process1
  (process!
   name : "clean"
   script : #<"""
    {{script1}} --data {{data}} --output {{out}}
   """
   ))

(define process2
  (process!
   name : "normalize"
   script : #<"""
    {{script2}} --data {{process1}} --output {{out}}
   """
   )
  )

(output!
 "processed-data.csv" : process2
 )
