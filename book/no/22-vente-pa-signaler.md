# Vente på Exec-signaler

## Mål

Etter denne leksjonen skal du kunne sende en signalmaske til en task, vente på signaler og kontrollere hvilke bits som faktisk vekket tasken.

## Signal og Wait

E-VO 3.9.4s Exec FD definerer:

```text
Wait(signalSet)
Signal(task, signalSet)
```

`Signal()` mottar en task-peker og en **signalmaske**. `Wait()` mottar også en maske og returnerer signalbitene som gjorde at ventingen ble avsluttet.

Dette er grunnen til at kapittel 21 skilte signalnummeret fra signalmasken.

## Et deterministisk undervisningseksempel

Et ekte event-system har normalt en annen produsent: en device, message port, Intuition eller en annen task. Før vi introduserer disse ressursene bruker vi et mindre eksempel.

Programmet:

1. henter gjeldende task med `FindTask(NIL)`
2. allokerer et signalnummer
3. bygger signalmasken
4. setter signalet på gjeldende task med `Signal()`
5. kaller `Wait(mask)`
6. kontrollerer returmasken
7. frigjør signalnummeret

Signalet settes **før** `Wait()`. Dermed ligger biten allerede pending når tasken venter, og eksemplet trenger ingen ekstra task bare for å demonstrere signalmekanismen.

## Kontroller returmasken

Vi tester:

```text
IF received AND signalMask
```

Det er viktigere enn å anta at enhver retur fra `Wait()` betyr vår hendelse. Senere vil én event loop ofte vente på flere bits samtidig.

```text
received := Wait(portMask OR timerMask OR breakMask)
```

Da må hver relevant bit testes separat.

## Cleanup

Signalnummeret er fortsatt den eide ressursen. Det frigjøres etter at signalet er konsumert.

Eksemplet har også en defensiv setup-feilbane: dersom task-pekeren mot formodning ikke er gyldig etter at signalet ble allokert, frigjøres signalet før programmet avslutter.

## Eksempel

Se `examples/22-exec-wait/self-signal.e`.

Forventet suksessoutput:

```text
signal received
```

Qualification-casen låses først etter faktisk E-VO 3.9.4-kompilering og amiga-runtime-kjøring.

## Oppsummering

`Signal()` setter signalbits for en task. `Wait()` venter på en maske og returnerer hvilke ventede bits som ble mottatt. Dette er kjernen vi trenger før message ports og event loops.
