# 01 — Verdier og variabler

Programmer blir nyttige når de kan arbeide med data som kan endres.

## Mål

Etter kapitlet skal du kunne skille mellom en fast verdi og en variabel, deklarere en enkel variabel og bruke den i utskrift.

## Eksempel

```e
PROC main()
  DEF year
  year := 2026
  WriteF('EduAmigaE year: \d\n', year)
ENDPROC
```

**Kompatibilitet:** E33.

`DEF year` gir prosedyren en variabel. Tilordningen `year := 2026` lagrer verdien. `\d` i `WriteF` er plassen der tallverdien skrives.

## Kjør det

```sh
eduamigae build examples/01-values/values.e
eduamigae run build/values
```

## Endre det

Endre året. Legg så til en variabel til og skriv begge verdiene.

## Tenk

Hva er forskjellen mellom tallet `2026` i kildekoden og variabelen `year` etter at programmet har startet?

## Øvelse

Lag variablene `a` og `b`, gi dem to forskjellige heltallsverdier og skriv dem på hver sin linje.

## Utfordring

Legg til en tredje variabel som får verdien `a+b`, og skriv resultatet.

## Oppsummering

En verdi er data. En variabel gir programmet et navn på et sted der data kan lagres og senere brukes. Neste steg er uttrykk og operatorer.
