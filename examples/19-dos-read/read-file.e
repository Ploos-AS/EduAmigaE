/* EduAmigaE E33: complete DOS file write/read lifetime */

MODULE 'dos/dos'

PROC main()
  DEF file, text='EduAmigaE\n', length, transferred
  DEF buffer[32]:ARRAY OF CHAR

  length := StrLen(text)

  file := Open('T:eduamigae-m4-read.txt', MODE_NEWFILE)
  IF file
    transferred := Write(file, text, length)
    Close(file)

    IF transferred = length
      file := Open('T:eduamigae-m4-read.txt', MODE_OLDFILE)
      IF file
        transferred := Read(file, buffer, length)
        Close(file)

        IF transferred = length
          buffer[length] := 0
          WriteF('read=\s', buffer)
        ELSE
          WriteF('read failed\n')
        ENDIF
      ELSE
        WriteF('reopen failed\n')
      ENDIF
    ELSE
      WriteF('write failed\n')
    ENDIF
  ELSE
    WriteF('create failed\n')
  ENDIF
ENDPROC
