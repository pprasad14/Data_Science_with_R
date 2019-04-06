fib = function(n) {
  if(n <= 1) return(n)
   else return(fib(n-1) + fib(n-2))
}
stop = 1
while(stop == 1){
  n = as.integer(readline("no of terms? "))
  if(n <= 0){
       print("Plese enter a positive integer")
    } else {
    print("Fibonacci sequence:")
    for(i in 0:(n-1)) {
      print(fib(i))
    }
    } 
  stop = readline("continue? 1 if yes, 0 if no : ")
}
