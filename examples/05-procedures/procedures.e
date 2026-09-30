/* EduAmigaE E33: procedures, parameters and return values */

PROC square(value)
  RETURN value * value
ENDPROC

PROC main()
  DEF result
  result := square(7)
  WriteF('square=\d\n', result)
ENDPROC
