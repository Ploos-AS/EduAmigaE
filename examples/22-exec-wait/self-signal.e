/* EduAmigaE E33: signal the current task and consume it with Wait */

MODULE 'exec/tasks'

PROC main()
  DEF task:PTR TO tc
  DEF signalNumber, signalMask, received

  task := FindTask(NIL)
  signalNumber := AllocSignal(-1)

  IF (task <> NIL) AND (signalNumber <> -1)
    signalMask := Shl(1, signalNumber)

    Signal(task, signalMask)
    received := Wait(signalMask)

    IF received AND signalMask
      WriteF('signal received\n')
    ELSE
      WriteF('signal missing\n')
    ENDIF

    FreeSignal(signalNumber)
  ELSE
    IF signalNumber <> -1 THEN FreeSignal(signalNumber)
    WriteF('signal setup failed\n')
  ENDIF
ENDPROC
