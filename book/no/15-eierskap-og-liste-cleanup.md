# Eierskap og generell liste-cleanup

## Mål

Etter denne leksjonen skal du kunne bygge en liste gjennom en prosedyre, endre en peker via en peker-til-peker og frigjøre en liste med vilkårlig antall noder uten å miste resten av kjeden.

## Endre listehodet

Hvis en prosedyre bare mottar verdien til `head`, kan den arbeide med noden, men den trenger adressen til selve pekervariabelen for å erstatte listehodet. Derfor bruker eksemplet:

```text
PROC pushFront(head:PTR TO PTR TO node, value)
```

Kalleren sender `{head}`. Inne i prosedyren er `head[]` den opprinnelige pekerverdien.

En ny node settes foran listen ved å la den peke på gammelt hode og deretter erstatte hodet:

```text
n.next := head[]
head[] := n
```

## Cleanup uten å miste neste node

Det farlige øyeblikket er frigjøringen. Etter `END current` kan vi ikke lenger stole på feltene i noden. Derfor må adressen til neste node lagres først:

```text
next := current.next
END current
current := next
```

`freeList()` gjentar dette til `current = NIL`. Algoritmen kjenner ikke antall noder på forhånd. Den mottar også `{head}`, slik at den til slutt kan sette `head[] := NIL`. Kalleren sitter dermed ikke igjen med en peker til frigjort minne.

## Eierskap

I dette eksemplet eier listen alle nodene som legges inn av `pushFront()`. `freeList()` avslutter levetiden til hele kjeden.

Det gir en enkel kontrakt: den som mottar det ferdigbygde listehodet, må sørge for at `freeList()` blir kalt nøyaktig én gang når listen ikke lenger trengs.

## Eksempel

Se `examples/15-list-ownership/list-ownership.e`. Tre kall til `pushFront()` bygger listen 10 → 20 → 30. Qualification-casen `list-ownership-e33` kontrollerer traverseringen.

## Endre det

Legg inn en fjerde verdi. Forutsi rekkefølgen før du kjører programmet.

## Tenk

Hvorfor lagrer `freeList()` `current.next` før `END current`, og ikke etterpå?

## Oppgave

Lag en prosedyre som teller noder uten å endre listehodet.

## Utfordring

Skisser hvordan en funksjon som fjerner første node kan overføre eierskap korrekt og samtidig oppdatere `head`.

## Oppsummering

Peker-til-peker gjør det mulig å endre en peker hos kalleren. Ved cleanup må neste adresse bevares før nåværende node frigjøres. Dette gir oss en generell eierskapsmodell for dynamiske kjeder.
