/* EduAmigaE E33: DOS file ownership */

MODULE 'dos/dos'

PROC main()
  DEF file, text='EduAmigaE DOS file example\n', length, written

  file := Open('T:eduamigae-m4.txt', MODE_NEWFILE)
  IF file
    length := StrLen(text)
    written := Write(file, text, length)
    Close(file)

    IF written = length
      WriteF('file write ok\n')
    ELSE
      WriteF('file write failed\n')
    ENDIF
  ELSE
    WriteF('file open failed\n')
  ENDIF
ENDPROC
