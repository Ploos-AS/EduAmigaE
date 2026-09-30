/* EduAmigaE E33: list insertion and general cleanup */

OBJECT node
  value:LONG
  next:PTR TO node
ENDOBJECT

PROC pushFront(head:PTR TO PTR TO node, value)
  DEF n:PTR TO node

  NEW n
  IF n <> NIL
    n.value := value
    n.next := head[]
    head[] := n
  ENDIF
ENDPROC

PROC freeList(head:PTR TO node)
  DEF current:PTR TO node, next:PTR TO node

  current := head
  WHILE current <> NIL
    next := current.next
    END current
    current := next
  ENDWHILE
ENDPROC

PROC main()
  DEF head:PTR TO node, current:PTR TO node

  head := NIL
  pushFront({head}, 30)
  pushFront({head}, 20)
  pushFront({head}, 10)

  current := head
  WHILE current <> NIL
    WriteF('node=\d\n', current.value)
    current := current.next
  ENDWHILE

  freeList(head)
ENDPROC
