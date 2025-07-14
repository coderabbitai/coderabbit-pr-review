import os, sys  # F401: sys imported but unused

def my_function(  x, y ):
  print(  "Result:",x+y )  # E201, E202, E231, E221

class myclass:  # N801: class name should use CapWords convention
 def __init__(self):
     self.value =42  # E225: missing whitespace around operator
     
 def doSomething(self):  # N802: function name should be snake_case
    if( self.value>0 ):
         print("Positive")
    else:
         print( "Not positive" )
         
my_function(1,2)
