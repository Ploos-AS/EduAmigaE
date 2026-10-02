/* EduAmigaE E33: acquire, check, use and release an Exec library */

PROC main()
  DEF dosbase

  dosbase := OpenLibrary('dos.library', 33)
  IF dosbase
    WriteF('dos.library opened\n')
    CloseLibrary(dosbase)
  ELSE
    WriteF('dos.library unavailable\n')
  ENDIF
ENDPROC
