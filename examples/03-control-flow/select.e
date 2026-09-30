/* EduAmigaE E33: choosing with SELECT */

PROC main()
  DEF value
  value := 2
  SELECT value
  CASE 1; WriteF('one\n')
  CASE 2; WriteF('two\n')
  CASE 3; WriteF('three\n')
  ENDSELECT
ENDPROC
