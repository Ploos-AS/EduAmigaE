/* EduAmigaE E33: cancel an asynchronous timer.device request safely */

MODULE 'devices/timer'

PROC main()
  DEF port:PTR TO mp
  DEF request:PTR TO timerequest

  port := CreateMsgPort()
  IF port
    request := CreateIORequest(port, SIZEOF timerequest)
    IF request
      IF OpenDevice(TIMERNAME, UNIT_MICROHZ, request, 0) = 0
        request.io.command := TR_ADDREQUEST
        request.time.secs := 5
        request.time.micro := 0

        SendIO(request)

        IF CheckIO(request) = NIL
          AbortIO(request)
        ENDIF

        WaitIO(request)
        WriteF('timer request stopped\n')

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
