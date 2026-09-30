# Dynamisk minne med NEW og END

## Mål

Etter denne leksjonen skal du kunne allokere minne med `NEW`, kontrollere om allokeringen lyktes, bruke minnet gjennom en peker og frigjøre det med `END`.

## Konsept

Så langt har pekerne våre pekt på variabler som allerede eksisterte. Noen ganger må programmet be om minne mens det kjører. Amiga E har `NEW` for dette.

For en `PTR TO LONG` kan mønsteret være:

```text
NEW p
IF p <> NIL
  ^p := 12345
  ...
  END p
ENDIF
```

`NIL` betyr her at vi ikke fikk en brukbar peker. Programmet må derfor kontrollere resultatet før pekeren derefereres.

`END p` frigjør allokeringen. Etter frigjøringen skal programmet ikke fortsette å bruke minnet gjennom `p`.

## Eksempel

Se `examples/12-dynamic-memory/new-end.e`. Qualification-casen heter `new-end-e33`.

Eksemplet har én tydelig eier av allokeringen: samme prosedyre som utfører `NEW p`, er også ansvarlig for `END p`.

## Eierskap og levetid

For hvert dynamisk minneområde bør du kunne svare på tre spørsmål:

1. Hvem eier allokeringen?
2. Hvor lenge er den gyldig?
3. Hvor blir den frigjort?

Et enkelt kursmønster er: **én vellykket `NEW` skal ha en tydelig tilsvarende `END`**. Senere møter vi kontrollflyt og systemressurser som krever mer avansert cleanup.

## Dynamiske arrays

`NEW` kan også allokere flere elementer. Eksemplet `examples/12-dynamic-memory/dynamic-array.e` bruker:

```text
NEW arr[5]
...
END arr[5]
```

Mellom disse punktene kan `arr` indekseres som `arr[0]` til `arr[4]`. Størrelsen er en del av både allokeringen og frigjøringen; vi holder derfor antallet synlig og identisk i dette introduksjonseksemplet.

Qualification-casen `dynamic-array-e33` forventer verdiene 0, 10, 20, 30 og 40.

## Kjør det

Bygg og test eksemplet. Normal output er `allocated=12345`.

## Endre det

Endre verdien som skrives gjennom `^p`. Følg pekeren fra deklarasjon via allokering og bruk til frigjøring.

## Tenk

Hva ville skjedd dersom programmet brukte `^p` uten først å kontrollere at `p <> NIL`?

## Oppgave

Lag en ny `PTR TO LONG`, alloker den, lagre en verdi, skriv den ut og frigjør allokeringen.

## Utfordring

Tegn levetiden til allokeringen som en linje fra vellykket `NEW` til `END`. Marker alle steder der pekeren brukes.

## Oppsummering

`NEW` oppretter dynamisk lagring, resultatet må kontrolleres, og `END` avslutter levetiden. Dette er grunnlaget for å forstå eierskap og senere AmigaOS-ressurser.
