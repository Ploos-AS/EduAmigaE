/* EduAmigaE E33: put and receive one Exec message */

MODULE 'exec/ports'

PROC main()
  DEF port:PTR TO mp
  DEF message:PTR TO mn
  DEF received:PTR TO mn

  port := CreateMsgPort()
  IF port
    NEW message
    IF message
      message.replyport := NIL
      message.length := SIZEOF mn

      PutMsg(port, message)
      WaitPort(port)
      received := GetMsg(port)

      IF received = message
        WriteF('message received\n')
      ELSE
        WriteF('message mismatch\n')
      ENDIF

      END message
    ELSE
      WriteF('message allocation failed\n')
    ENDIF

    DeleteMsgPort(port)
  ELSE
    WriteF('message port unavailable\n')
  ENDIF
ENDPROC
