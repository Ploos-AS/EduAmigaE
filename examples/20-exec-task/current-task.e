/* EduAmigaE E33: inspect the current Exec task */

MODULE 'exec/tasks'

PROC main()
  DEF task:PTR TO tc

  task := FindTask(NIL)
  IF task
    WriteF('current task ok\n')
  ELSE
    WriteF('current task missing\n')
  ENDIF
ENDPROC
