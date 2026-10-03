/* EduAmigaE E33: asynchronous timer.device I/O */

MODULE 'devices/timer'

PROC main()
  DEF port:PTR TO mp
  DEF request:PTR TO timerequest
  DEF completed

  port := CreateMsgPort()
  IF port
    request := CreateIORequest(port, SIZEOF timerequest)
    IF request
      IF OpenDevice(TIMERNAME, UNIT_MICROHZ, request, 0) = 0
        request.io.command := TR_ADDREQUEST
        request.time.secs := 0
        request.time.micro := 10000

        SendIO(request)

        completed := CheckIO(request)
        /* CheckIO is an observation only; its timing is deliberately not printed. */
        IF completed = NIL
          /* The request is still in flight here. */
        ENDIF

        WaitIO(request)
        WriteF('timer request complete\n')

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
