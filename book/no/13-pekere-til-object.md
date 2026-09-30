# Pekere til OBJECT

## Mål

Etter denne leksjonen skal du kunne kombinere `OBJECT`, `PTR TO`, `NEW` og `END` til en dynamisk struktur med navngitte felt.

## Fra verdi til dynamisk objekt

Tidligere brukte vi en lokal `point` direkte. Nå deklarerer vi:

```text
DEF p:PTR TO point
```

`p` er ikke selve punktet. Den er en peker som kan referere til en `point`-struktur.

Etter `NEW p` og kontroll av `p <> NIL` kan feltene brukes direkte gjennom pekeren:

```text
p.x := 10
p.y := 20
```

Til slutt frigjør `END p` allokeringen.

## Eksempel

Se `examples/13-object-pointers/object-pointer.e`. Qualification-casen heter `object-pointer-e33` og forventer `point=10,20`.

## Eierskap

Eksemplet beholder samme enkle eierskapsregel som for dynamisk minne: prosedyren allokerer objektet, bruker det og frigjør det før den returnerer.

Når strukturer senere begynner å peke på andre strukturer, blir dette viktigere: vi må vite hvem som eier hver allokering og i hvilken rekkefølge de skal frigjøres.

## Endre det

Legg til et tredje felt `z`, sett en verdi og skriv ut alle tre feltene.

## Tenk

Hva er forskjellen mellom en lokal `DEF p:point` og `DEF p:PTR TO point` fulgt av `NEW p`?

## Oppgave

Lag et `OBJECT measurement` med to felt. Alloker det gjennom en typet peker, fyll feltene, skriv dem ut og frigjør objektet.

## Utfordring

Tegn objektet og pekerens forhold til det. Marker tydelig hvilken del som er pekerverdien og hvilken del som er den dynamisk allokerte strukturen.

## Oppsummering

En `PTR TO` et `OBJECT` lar oss arbeide med dynamiske strukturer. Dette er byggesteinen vi trenger før vi lager strukturer som lenker til andre strukturer.
