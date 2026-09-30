/* EduAmigaE E33: expressions and operators */

PROC main()
  DEF a, b, sum, product
  a := 6
  b := 7
  sum := a + b
  product := a * b
  WriteF('sum=\d product=\d\n', sum, product)
ENDPROC
