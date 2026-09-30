# 06 — Strenger

## Mål

Lære å behandle tekst som data og sende en streng til `WriteF`.

## Eksempel

```e
PROC main()
  DEF name
  name := 'Amiga'
  WriteF('Hello, \s!\n', name)
ENDPROC
```

**Kompatibilitet:** E33.

Variabelen `name` refererer til teksten `'Amiga'`. I formatstrengen betyr `\s` at en streng skal settes inn på den posisjonen.

## Kjør og endre

```sh
eduamigae build examples/06-strings/strings.e
eduamigae run build/strings
```

Bytt navn og legg til en ny tekstverdi. Skriv begge i samme `WriteF`-kall.

## Tenk

Et tall og en tekststreng er begge data, men hvorfor trenger `WriteF` forskjellig formatinformasjon for dem?

## Øvelse

Lag variablene `machine` og `language` og skriv en hel setning med begge.

## Utfordring

Lag en prosedyre som tar en streng som parameter og skriver en enkel velkomstmelding.

## Oppsummering

Strenger lar programmer arbeide med tekst som data. Senere skal vi se nærmere på hvordan strenger faktisk representeres i minnet.
