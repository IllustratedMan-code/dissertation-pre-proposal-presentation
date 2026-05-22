
(define path1
  (file! "src/main.rs"))

(define path2
  (file! "src/vm.csv"))


(define data
  (read-csv "mydata.csv"))


(set! metadata
  (~> metadata 
      (with-column "c" (list path1 path2))))

(define csv (as-csv metadata "," ".csv"))

(define myscript (file! "myscript.py"))

(process!
 script : #<<"""
  {{myscript}} {{csv}}
 """
 )
