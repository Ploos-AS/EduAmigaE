/* EduAmigaE E33: dynamically allocated OBJECT through a typed pointer */

OBJECT point
  x, y
ENDOBJECT

PROC main()
  DEF p:PTR TO point

  NEW p
  IF p <> NIL
    p.x := 10
    p.y := 20
    WriteF('point=\d,\d\n', p.x, p.y)
    END p
  ELSE
    WriteF('allocation failed\n')
  ENDIF
ENDPROC
