/* EduAmigaE E33: minimal singly linked list */

OBJECT node
  value:LONG
  next:PTR TO node
ENDOBJECT

PROC main()
  DEF first:PTR TO node, second:PTR TO node, current:PTR TO node

  NEW first
  IF first <> NIL
    NEW second
    IF second <> NIL
      first.value := 10
      first.next := second
      second.value := 20
      second.next := NIL

      current := first
      WHILE current <> NIL
        WriteF('node=\d\n', current.value)
        current := current.next
      ENDWHILE

      END second
    ELSE
      WriteF('allocation failed\n')
    ENDIF
    END first
  ELSE
    WriteF('allocation failed\n')
  ENDIF
ENDPROC
