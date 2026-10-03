/* EduAmigaE E33: synchronous timer.device I/O */

MODULE 'devices/timer'

PROC main()
  DEF port:PTR TO mp
  DEF request:PTR TO timerequest
  DEF result

  port := CreateMsgPort()
  IF port
    request := CreateIORequest(port, SIZEOF timerequest)
    IF request
      IF OpenDevice(TIMERNAME, UNIT_MICROHZ, request, 0) = 0
        request.io.command := TR_ADDREQUEST
        request.time.secs := 0
        request.time.micro := 10000

        result := DoIO(request)
        IF result = 0
          WriteF('timer request complete\n')
        ELSE
          WriteF('timer request failed\n')
        ENDIF

        CloseDevice(request)
      ELSE
        WriteF('timer.device unavailable\n')
      ENDIF

      DeleteIORequest(request)
    ELSE
      WriteF('io request unavailable\n')
    ENDIF

    DeleteMsgPort(port)
  ELSE
    WriteF('message port unavailable\n')
  ENDIF
ENDPROC
