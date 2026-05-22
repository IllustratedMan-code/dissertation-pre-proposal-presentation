

(process!
 name : "nix-hello"
 nix : #<"""
  cowsay
 """
 script : #<"""
  cowsay 'Hi world!'
 """
 )
