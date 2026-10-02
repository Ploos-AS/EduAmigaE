# Ressurser i AmigaOS

## Mål

Etter denne leksjonen skal du kunne forklare den grunnleggende livssyklusen til en AmigaOS-ressurs og planlegge cleanup før du begynner å bruke konkrete Exec- og DOS-API-er.

## Fra minne til operativsystemressurser

I M3 brukte vi `NEW` og `END` og gjorde eierskapet eksplisitt. AmigaOS-programmering bygger videre på den samme tankegangen, men ressursen kan nå være en fil, et bibliotek, en port, en melding, en device eller en I/O-request.

Den sentrale modellen er:

```text
acquire -> check -> use -> release
```

Et vellykket acquire gir programmet en ressurs eller et håndtak som senere må frigis med den API-operasjonen som hører til ressursen.

## Sjekk før bruk

Et acquire-kall kan feile. Programmet må derfor kontrollere resultatet før ressursen brukes. Et mislykket acquire gir ikke programmet en gyldig ressurs å arbeide med eller frigjøre.

## Frigjør i motsatt rekkefølge

Når flere ressurser avhenger av hverandre, er en god grunnregel å frigjøre dem i motsatt rekkefølge av hvordan de ble anskaffet:

```text
acquire A
  acquire B
    acquire C
    release C
  release B
release A
```

Dette blir spesielt viktig når bare deler av oppstarten lykkes.

## Ett ansvar per ressurs

For hver ressurs skal du kunne svare på fire spørsmål:

1. Hvem anskaffer den?
2. Hvordan ser vi at anskaffelsen lykkes?
3. Hvem eier den mens den brukes?
4. Hvilket kall avslutter levetiden?

Hvis ett av svarene er uklart, er cleanup-modellen også uklar.

## Hvorfor ingen qualification-case ennå?

Dette kapitlet etablerer kontrakten før vi binder undervisningen til konkrete Exec- og DOS-funksjoner. De neste kapitlene bruker ekte E-VO 3.9.4-moduler og AmigaOS-API-er, og executable caser låses først etter at syntaks og runtime-forutsetninger er kontrollert.


## Første konkrete Exec-ressurs

E-VO 3.9.4 beskriver Exec-kallene `OpenLibrary(libName, version)` og `CloseLibrary(library)`. Eksemplet `examples/17-amigaos-resources/open-library.e` bruker dem til å åpne `dos.library` med minimum versjon 33.

Legg merke til kontrollflyten: `CloseLibrary()` ligger inne i grenen der `OpenLibrary()` faktisk lyktes. Programmet forsøker dermed aldri å frigjøre en ressurs det ikke eier.

Qualification-casen låses ikke ennå. Først skal eksemplet faktisk kompileres med den pinnede E-VO 3.9.4-toolchainen og kjøres gjennom de deklarerte amiga-runtime-profilene.

## Oppsummering

M3 lærte oss eierskap til minne og datastrukturer. M4 utvider samme disiplin til operativsystemressurser: anskaff, kontroller, bruk og frigjør.
