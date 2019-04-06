#create a calculator function

calc = function(a,b,c){
  if((b=='+')|(b=="plus")) print(paste(('sum is'),(a+c)))
  else if((b=='-')|(b=="minus")) print(paste(('difference is'),(a-c)))
  else if((b=='*')|(b=="into")) print(paste(('product is'),(a*c)))
  else if((b=='/')|(b=="divided")){
    if (c==0) print('divide by zero error')
    else print(paste(('division is'),(a/c)))
    }
  else print("wrong input !!")
}


stop = 1
while(stop == 1){
  print("for words, use 'plus' for +, 'minus' for -, 'into' for *, and 'divided' for / ")
  input = readline('enter expression with space,ex: "1 + 2"   or  "1 plus 2" :')
  temp = unlist(strsplit(input," ")) # strsplit(input," ") returns a list, so use unlist
  calc(as.integer(temp[1]),temp[2],as.integer(temp[3]))
  stop = readline('continue? if yes: 1, if no: 0 : ')
}
