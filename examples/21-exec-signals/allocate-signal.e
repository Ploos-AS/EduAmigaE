/* EduAmigaE E33: allocate and release an Exec signal bit */

PROC main()
  DEF signalNumber, signalMask

  signalNumber := AllocSignal(-1)
  IF signalNumber <> -1
    signalMask := Shl(1, signalNumber)
    IF signalMask
      WriteF('signal allocated\n')
    ENDIF
    FreeSignal(signalNumber)
  ELSE
    WriteF('signal unavailable\n')
  ENDIF
ENDPROC
