# Adresser og pekere

## Mål

Etter denne leksjonen skal du kunne forklare forskjellen mellom en verdi og adressen til verdien, deklarere en typet peker med `PTR TO`, hente en adresse og lese verdien gjennom pekeren.

## Konsept

En vanlig variabel inneholder en verdi. En peker inneholder adressen til data et annet sted i minnet. I Amiga E kan `PTR TO LONG` uttrykke at en peker skal brukes mot en `LONG`.

I eksemplet brukes `{value}` for å hente adressen til `value`. Uttrykket `^p` leser verdien som `p` peker på.

## Eksempel

Se `examples/11-pointers/pointers.e`.

Programmet oppretter en `LONG` med verdien 42, lar `p` peke på den og leser samme verdi gjennom pekeren.

## Kjør det

Bygg og test eksemplet gjennom EduAmigaE-verktøyene. Qualification-casen heter `pointers-e33`.

## Skrive gjennom en peker

En dereferert peker kan også brukes på venstre side av en tilordning. I `examples/11-pointers/pointer-write.e` gjør:

```text
^p := 99
```

at selve `value` endres, fordi `p` peker på denne variabelen. Qualification-casen `pointer-write-e33` kontrollerer at både direkte lesing av `value` og lesing gjennom `^p` gir 99.

Dette er en viktig forskjell: tilordning til `p` endrer hvilken adresse pekeren inneholder, mens tilordning til `^p` endrer dataene på adressen.

## Endre det

Endre startverdien fra 42 til en annen verdi. Forutsi begge tallene i utskriften før du kjører programmet.

## Tenk

Hvorfor er det nyttig at typen på pekeren beskriver hva som finnes på adressen?

## Oppgave

Lag to `LONG`-variabler og én `PTR TO LONG`. La pekeren først peke på den ene og deretter den andre, og skriv ut verdien etter hver endring.

## Utfordring

Undersøk forskjellen mellom selve pekerverdien, adressen den inneholder og dataene som leses gjennom pekeren. Ikke bruk dynamisk allokering ennå.

## Oppsummering

`PTR TO` beskriver en typet peker, `{value}` kan hente adressen til en verdi, og `^p` kan dereferere pekeren. Neste steg er mutasjon gjennom pekere og deretter eksplisitt allokering og frigjøring.
