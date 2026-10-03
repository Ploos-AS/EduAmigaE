/* EduAmigaE E33: complete Exec request/reply lifetime */

MODULE 'exec/ports'

PROC main()
  DEF requestPort:PTR TO mp
  DEF replyPort:PTR TO mp
  DEF message:PTR TO mn
  DEF received:PTR TO mn
  DEF replied:PTR TO mn
  DEF ownsMessage=FALSE

  requestPort := CreateMsgPort()
  replyPort := CreateMsgPort()

  IF requestPort AND replyPort
    NEW message
    IF message
      ownsMessage := TRUE
      message.ln.type := NT_MESSAGE
      message.replyport := replyPort
      message.length := SIZEOF mn

      PutMsg(requestPort, message)
      ownsMessage := FALSE

      WaitPort(requestPort)
      received := GetMsg(requestPort)

      IF received = message
        ReplyMsg(received)

        WaitPort(replyPort)
        replied := GetMsg(replyPort)

        IF replied = message
          ownsMessage := TRUE
          WriteF('message replied\n')
        ELSE
          WriteF('reply mismatch\n')
        ENDIF
      ELSE
        WriteF('request mismatch\n')
      ENDIF

      IF ownsMessage THEN END message
    ELSE
      WriteF('message allocation failed\n')
    ENDIF
  ELSE
    WriteF('message port setup failed\n')
  ENDIF

  IF replyPort THEN DeleteMsgPort(replyPort)
  IF requestPort THEN DeleteMsgPort(requestPort)
ENDPROC
