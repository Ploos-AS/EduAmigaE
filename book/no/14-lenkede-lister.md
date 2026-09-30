# En enkel lenket liste

## Mål

Etter denne leksjonen skal du kunne lage et selvrefererende `OBJECT`, lenke dynamisk allokerte noder sammen, traversere listen og frigjøre nodene.

## En node som peker på neste node

En enkeltlenket liste kan bygges av noder som inneholder både data og en peker til neste node:

```text
OBJECT node
  value:LONG
  next:PTR TO node
ENDOBJECT
```

Feltet `next` har samme strukturelle type som objektet det finnes i. Dette er en selvrefererende datastruktur.

## To noder

Eksemplet i `examples/14-linked-list/linked-list.e` allokerer `first` og `second`. Deretter settes:

```text
first.next := second
second.next := NIL
```

`NIL` markerer slutten på listen.

## Traversering

En egen peker, `current`, starter på første node. Så lenge den ikke er `NIL`, brukes noden og pekeren flyttes videre:

```text
current := first
WHILE current <> NIL
  WriteF('node=\d\n', current.value)
  current := current.next
ENDWHILE
```

Dette mønsteret er grunnleggende for mange dynamiske datastrukturer.

## Cleanup

Eksemplet vet på forhånd at det finnes maksimalt to noder og frigjør derfor `second` og deretter `first`. Vi skal senere generalisere cleanup slik at en liste med vilkårlig antall noder kan frigjøres ved traversering.

Qualification-casen `linked-list-e33` forventer to linjer: `node=10` og `node=20`.

## Endre det

Legg til en tredje node med verdien 30 og koble den mellom `second` og `NIL`.

## Tenk

Hvorfor trenger traverseringen en egen `current`-peker i stedet for å flytte `first`?

## Oppgave

Bygg en liste med tre noder og skriv ut alle verdiene ved å traversere `next`.

## Utfordring

Skisser en algoritme som kan frigjøre en liste med ukjent antall noder uten å miste adressen til neste node.

## Oppsummering

Et selvrefererende `OBJECT` kan representere en node, `next` binder nodene sammen, `NIL` avslutter kjeden, og en separat peker kan traversere listen. Neste steg er generell innsetting og cleanup.
