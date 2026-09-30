/* EduAmigaE E33: addresses and typed pointers */

PROC main()
  DEF value=42:LONG
  DEF p:PTR TO LONG

  p := {value}
  WriteF('value=\d pointer=\d\n', value, ^p)
ENDPROC
