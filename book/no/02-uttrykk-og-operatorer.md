# 02 — Uttrykk og operatorer

## Mål

Lære hvordan verdier kombineres til nye verdier med aritmetiske operatorer.

## Eksempel

```e
PROC main()
  DEF a, b, sum, product
  a := 6
  b := 7
  sum := a + b
  product := a * b
  WriteF('sum=\d product=\d\n', sum, product)
ENDPROC
```

**Kompatibilitet:** E33.

Et uttrykk beregner en verdi. `a + b` og `a * b` er uttrykk; resultatene lagres i variabler.

## Kjør og endre

```sh
eduamigae build examples/02-expressions/expressions.e
eduamigae run build/expressions
```

Prøv andre verdier og operatorene `+`, `-`, `*` og heltallsdivisjon. Bruk parenteser når du vil gjøre evalueringsrekkefølgen tydelig.

## Tenk

Hvorfor er `a + b * 2` ikke nødvendigvis det samme som `(a + b) * 2`?

## Øvelse

Beregn omkretsen til et rektangel fra to variabler.

## Utfordring

Beregn både areal og omkrets og skriv begge resultatene.

## Oppsummering

Uttrykk transformerer data. Neste kapittel bruker sammenligninger til å velge hvilken kode som skal kjøres.
