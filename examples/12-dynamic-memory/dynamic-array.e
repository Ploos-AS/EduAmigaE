/* EduAmigaE E33: dynamically allocated array */

PROC main()
  DEF arr:PTR TO LONG
  DEF i

  NEW arr[5]
  IF arr <> NIL
    FOR i := 0 TO 4 DO arr[i] := i * 10
    WriteF('array=\d,\d,\d,\d,\d\n',
      arr[0], arr[1], arr[2], arr[3], arr[4])
    END arr[5]
  ELSE
    WriteF('allocation failed\n')
  ENDIF
ENDPROC
