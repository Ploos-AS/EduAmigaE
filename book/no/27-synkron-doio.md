# Synkron I/O med DoIO

## Mål

Etter denne leksjonen skal du kunne fylle ut en timer-request, sende den synkront med `DoIO()` og forklare hva synkron betyr for requestens levetid.

## Fra åpen device til operasjon

Forrige leksjon opprettet infrastrukturen:

```text
message port -> I/O request -> open timer.device
```

Nå bruker vi requesten til en faktisk operasjon.

E-VO 3.9.4s `devices/timer` definerer:

```text
TR_ADDREQUEST
timerequest.io
timerequest.time.secs
timerequest.time.micro
```

Upstream `extra_examples/clock.e` bruker samme felt for timerforespørsler.

## Requesten

Eksemplet setter:

```text
request.io.command := TR_ADDREQUEST
request.time.secs := 0
request.time.micro := 10000
```

Det beskriver en kort timer-request på 10 000 mikrosekunder.

## DoIO blokkerer

Deretter kaller vi:

```text
result := DoIO(request)
```

`DoIO()` er den synkrone formen. Kallet returnerer først når operasjonen er ferdig.

Dermed er eierskapet enkelt:

```text
prepare request
      |
      v
DoIO(request)
      |
      | task waits
      v
operation complete
      |
      v
request may be reused
```

Når `DoIO()` har returnert, er requesten ikke lenger in flight.

## Returverdi

Eksemplet tester returverdien og bruker null som suksess:

```text
IF result = 0
```

Vi skriver bare deterministisk resultattekst, ikke tidsmålinger. Scheduler- og emulator-timing skal derfor ikke påvirke forventet stdout.

## Cleanup

Etter at `DoIO()` er ferdig kan vi følge samme cleanup som før:

```text
CloseDevice(request)
DeleteIORequest(request)
DeleteMsgPort(port)
```

Det ville vært feil å gjøre denne cleanupen mens en asynkron request fortsatt var aktiv. Det skillet blir tema i neste leksjon.

## Eksempel

Se `examples/27-device-doio/timer-doio.e`.

Forventet suksessoutput:

```text
timer request complete
```

Qualification-casen låses først etter faktisk E-VO 3.9.4-kompilering og amiga-runtime-kjøring.

## Neste steg

Neste leksjon erstatter `DoIO()` med `SendIO()`. Da returnerer kontrollen før operasjonen er ferdig, og programmet må eksplisitt håndtere completion med `WaitIO()` og sikker cancellation med `AbortIO()`.

## Oppsummering

`DoIO()` sender en device-request og venter på at den fullføres. Etter retur er requesten igjen tilgjengelig for programmet, noe som gjør synkron I/O til den enkleste device-modellen.
