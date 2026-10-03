# Devices og I/O-requestens levetid

## Mål

Etter denne leksjonen skal du kunne åpne en Amiga device med en I/O request og rydde opp port, request og device i riktig rekkefølge.

## En device trenger mer enn OpenDevice

Amiga devices bruker meldingsmekanismen vi allerede har lært. Før vi kan åpne `timer.device`, oppretter vi derfor en message port og en I/O request.

E-VO 3.9.4s `devices/timer` definerer `OBJECT timerequest`, som inneholder en Exec `io`-struktur og timerdata.

Upstream `extra_examples/clock.e` bruker samme kjede som kurseksemplet:

```text
CreateMsgPort()
CreateIORequest(port, SIZEOF timerequest)
OpenDevice(...)
```

## Tre nestede levetider

Ressursene avhenger av hverandre:

```text
message port
    |
    +-- I/O request
           |
           +-- opened device
```

Derfor rydder vi i motsatt rekkefølge:

```text
CloseDevice(request)
DeleteIORequest(request)
DeleteMsgPort(port)
```

Requesten må eksistere mens devicen er åpen, og porten må eksistere mens requesten kan bruke den.

## OpenDevice sin returverdi

Upstream E-VO-eksemplet tester:

```text
OpenDevice(...)=0
```

Null betyr at devicen ble åpnet. Bare da har vi en device-levetid som skal avsluttes med `CloseDevice()`.

Dersom `OpenDevice()` feiler, skal requesten fortsatt slettes og porten fortsatt slettes, men vi skal ikke kalle `CloseDevice()` på en device som aldri ble åpnet.

## Hvorfor timer.device?

`timer.device` er nyttig fordi den senere lar oss demonstrere både synkron og asynkron I/O uten filsystem- eller GUI-avhengigheter.

Vi bruker:

```text
TIMERNAME
UNIT_MICROHZ
```

fra E-VO-modulen `devices/timer`.

## Eksempel

Se `examples/26-device-lifetime/open-timer.e`.

Forventet suksessoutput:

```text
timer.device opened
```

Qualification-casen låses først etter faktisk E-VO 3.9.4-kompilering og amiga-runtime-kjøring.

## Neste steg

Nå eier vi infrastrukturen for en device-operasjon. Neste leksjon fyller ut `timerequest` og sender en synkron operasjon med `DoIO()`. Etter det kan vi gå videre til `SendIO()`, `WaitIO()` og cancellation.

## Oppsummering

Device-programmering bygger videre på Exec-meldinger. Opprett port, opprett request, åpne device; lukk deretter device, slett request og slett port i motsatt rekkefølge.
