# 00 — Kom i gang

Målet er å gå fra kildekode til et kjørbart Amiga-program og forstå de tre delene i det første programmet.

## Første program

```e
PROC main()
  WriteF('Hello from EduAmigaE!\n')
ENDPROC
```

**Kompatibilitet:** E33 — eksemplet skal kunne uttrykkes uten E-VO-spesifikke språktillegg.

`PROC main()` starter programmets hovedprosedyre. `WriteF()` skriver tekst. `ENDPROC` avslutter prosedyren.

## Kjør det

Med studentmiljøet og E-VO 3.9.4 provisionert:

```sh
eduamigae build examples/00-hello/hello.e
eduamigae run build/hello
```

## Endre det

Bytt teksten til en egen melding, bygg på nytt og observer at programflyten er uendret mens dataene er endret.

## Tenk

Hvorfor er teksten data, mens `PROC`, `WriteF` og `ENDPROC` beskriver programstruktur og handling?

## Øvelse

Lag et program som skriver to linjer. Bruk to `WriteF()`-kall først. Prøv deretter én tekststreng med linjeskift.

## Utfordring

Skriv navn, maskintype og ett mål for kurset på tre separate linjer.

## Oppsummering

Du har sett kildekode, en prosedyre, et funksjonskall, en tekststreng og bygg/kjør-syklusen. Neste kapittel går fra faste tekster til verdier og variabler.
