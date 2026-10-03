/* EduAmigaE E33: create and release an Exec message port */

MODULE 'exec/ports'

PROC main()
  DEF port:PTR TO mp
  DEF portMask

  port := CreateMsgPort()
  IF port
    portMask := Shl(1, port.sigbit)

    IF portMask
      WriteF('message port ready\n')
    ENDIF

    DeleteMsgPort(port)
  ELSE
    WriteF('message port unavailable\n')
  ENDIF
ENDPROC
