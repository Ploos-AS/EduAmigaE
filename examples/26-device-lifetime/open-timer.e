/* EduAmigaE E33: acquire and release timer.device */

MODULE 'devices/timer'

PROC main()
  DEF port:PTR TO mp
  DEF request:PTR TO timerequest

  port := CreateMsgPort()
  IF port
    request := CreateIORequest(port, SIZEOF timerequest)
    IF request
      IF OpenDevice(TIMERNAME, UNIT_MICROHZ, request, 0) = 0
        WriteF('timer.device opened\n')
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
