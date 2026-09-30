/* EduAmigaE E33: repetition with WHILE */

PROC main()
  DEF value
  value := 1
  WHILE value <= 3
    WriteF('while=\d\n', value)
    value := value + 1
  ENDWHILE
ENDPROC
