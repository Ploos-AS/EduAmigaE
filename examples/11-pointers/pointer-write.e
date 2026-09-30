/* EduAmigaE E33: mutate a value through a typed pointer */

PROC main()
  DEF value=42:LONG
  DEF p:PTR TO LONG

  p := {value}
  ^p := 99
  WriteF('value=\d pointer=\d\n', value, ^p)
ENDPROC
