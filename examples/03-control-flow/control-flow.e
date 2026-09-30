/* EduAmigaE E33: conditional control flow */

PROC main()
  DEF value
  value := 42
  IF value > 10
    WriteF('large\n')
  ELSE
    WriteF('small\n')
  ENDIF
ENDPROC
