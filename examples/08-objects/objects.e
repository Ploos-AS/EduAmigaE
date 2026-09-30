/* EduAmigaE E33: OBJECT as structured data */

OBJECT point
  x, y
ENDOBJECT

PROC main()
  DEF p:point
  p.x := 10
  p.y := 20
  WriteF('point=\d,\d\n', p.x, p.y)
ENDPROC
