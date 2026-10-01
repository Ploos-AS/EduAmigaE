# Egne moduler og programgrenser

## Mål

Etter denne leksjonen skal du kunne forklare hvorfor et større program deles i moduler, skille offentlig API fra intern implementasjon og lese et enkelt Amiga E-program som importerer en egen modul.

## Modulens kildekode

Eksemplet `examples/16-own-module/modules/edumath.e` starter med:

```text
OPT MODULE
```

Dette markerer kildefilen som en modul. Prosedyren som skal være offentlig eksporteres eksplisitt:

```text
EXPORT PROC doubleValue(value) IS value * 2
```

Dette er modulens lille API.

## Klienten

`main.e` importerer modulen:

```text
MODULE '*edumath'
```

Resten av programmet trenger bare å kjenne den eksporterte operasjonen. Hvordan modulen organiserer implementasjonen sin kan endres uten at klienten må eie den koden.

## Hvorfor denne grensen betyr noe

Når programmer blir større, ønsker vi ikke én enorm kildefil. En god modulgrense gjør ansvar tydelig, reduserer kobling og gjør kode enklere å teste og gjenbruke.

Dette blir spesielt viktig i M4 når systemkode begynner å håndtere Exec-, DOS- og andre AmigaOS-ressurser.

## Bygg og qualification

Dette er et flerfilseksempel. E-VO-guiden dokumenterer at `*` foran modulnavnet søker ved siden av klientens kildefil. Derfor kompileres `edumath.e` først til `edumath.m`, og klienten bruker `MODULE '*edumath'`. `scripts/build-own-module.sh` uttrykker denne rekkefølgen eksplisitt. Vi låser ikke en executable qualification-case før denne sekvensen faktisk er kjørt og verifisert med den pinnede E-VO-toolchainen.

Det skiller syntaks/proveniens fra faktisk toolchain-kvalifikasjon.

## Endre det

Legg til en eksportert prosedyre som tredobler et tall, og kall den fra `main.e`.

## Tenk

Hva bør være offentlig i en modul, og hva bør forbli implementasjonsdetaljer?

## Oppgave

Skisser en modul med to offentlige operasjoner og minst én intern hjelpeoperasjon.

## Utfordring

Del listekoden fra forrige leksjon i et offentlig liste-API og en klient. Bestem hvilke detaljer klienten egentlig trenger å kjenne.

## Oppsummering

`OPT MODULE` oppretter modulgrensen, `EXPORT` beskriver det offentlige API-et, og `MODULE` importerer API-et hos klienten. Nå kan vi organisere større programmer uten å blande alle ansvar i én fil.
