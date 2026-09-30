/* EduAmigaE E33: dynamic memory with NEW and END */

PROC main()
  DEF p:PTR TO LONG

  NEW p
  IF p <> NIL
    ^p := 12345
    WriteF('allocated=\d\n', ^p)
    END p
  ELSE
    WriteF('allocation failed\n')
  ENDIF
ENDPROC
