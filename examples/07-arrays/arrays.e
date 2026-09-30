/* EduAmigaE E33: arrays */

PROC main()
  DEF values[5]:ARRAY, i
  values[0] := 2
  values[1] := 4
  values[2] := 6
  values[3] := 8
  values[4] := 10

  FOR i := 0 TO 4
    WriteF('\d\n', values[i])
  ENDFOR
ENDPROC
