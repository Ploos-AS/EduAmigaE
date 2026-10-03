# Cancellation og sikker device-cleanup

## Mål

Etter denne leksjonen skal du kunne stoppe en asynkron I/O-request uten å frigjøre ressurser som devicen fortsatt kan bruke.

## Problemet

Etter `SendIO(request)` kan requesten være in flight. Programmet kan derfor ikke lukke device, slette request og slette port mens operasjonen fortsatt kan referere til dem.

## Check, abort, wait

Det robuste mønsteret er:

```text
IF CheckIO(request) = NIL
  AbortIO(request)
ENDIF

WaitIO(request)
```

`CheckIO()` forteller om requesten allerede er ferdig. Hvis den fortsatt er aktiv, ber `AbortIO()` devicen stoppe den. Men `AbortIO()` er ikke completion-beviset: `WaitIO()` må fortsatt brukes før requesten kan destrueres.

E-VO 3.9.4s eget `extra_examples/clock.e` bruker `AbortIO(tr)` etterfulgt av `WaitIO(tr)` ved avslutning med en aktiv timer-request.

## Cleanup-invarianten

`CloseDevice(request)` er bare tillatt når requesten ikke lenger er in flight. For en request sendt med `SendIO()` etablerer `WaitIO()` dette punktet.

Deretter kan vi rydde i motsatt rekkefølge:

```text
CloseDevice(request)
DeleteIORequest(request)
DeleteMsgPort(port)
```

## Hvorfor CheckIO først?

Hvis operasjonen allerede er ferdig, trenger vi ikke forsøke å avbryte den:

```text
already complete -> WaitIO
still active     -> AbortIO -> WaitIO
```

Begge banene møtes ved samme sikre completion-punkt.

## Eksempel

Se `examples/29-device-cancel/cancel-timer.e`.

Eksemplet starter en lang timer-request slik at cancellation-banen normalt blir brukt. Korrektheten er likevel ikke timing-avhengig: dersom requesten allerede er ferdig, hopper vi over `AbortIO()` og går fortsatt gjennom `WaitIO()`.

Stabil sluttlinje:

```text
timer request stopped
```

Qualification-casen låses først etter faktisk E-VO 3.9.4-kompilering og amiga-runtime-kjøring.

## Delvis acquisition

M4 bruker nå samme cleanup-prinsipp på flere nivåer:

```text
CreateMsgPort succeeds       -> DeleteMsgPort
CreateIORequest succeeds     -> DeleteIORequest
OpenDevice succeeds          -> CloseDevice
SendIO starts request        -> establish completion before cleanup
```

En cleanup-operasjon utføres bare for en ressurs som faktisk ble anskaffet, og avhengige ressurser avsluttes før ressursene de avhenger av.

## Oppsummering

`AbortIO()` ber om cancellation. `WaitIO()` etablerer completion. Først etter completion kan device, request og port frigjøres trygt.
