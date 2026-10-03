# Asynkron I/O med SendIO

## Mål

Etter denne leksjonen skal du kunne starte en device-operasjon uten å blokkere, kontrollere om requesten fortsatt er aktiv og vente til den er ferdig før cleanup.

## SendIO returnerer tidlig

`DoIO()` ventet til operasjonen var ferdig. `SendIO()` starter i stedet requesten og returnerer kontrollen til programmet.

```text
SendIO(request)
      |
      +--> device arbeider
      |
      +--> programmet fortsetter
```

Fra dette tidspunktet er requesten **in flight**.

## CheckIO

Exec FD-en definerer `CheckIO(ioRequest)`. Den lar programmet kontrollere om en asynkron request allerede er ferdig uten å vente.

Eksemplet bruker:

```text
completed := CheckIO(request)
IF completed = NIL
  WriteF('timer request in flight\n')
ENDIF
```

Timeren er kort, så den kan i prinsippet allerede ha rukket å fullføre før testen. Derfor er bare sluttmeldingen egnet som obligatorisk deterministisk qualification-output; teksten om `in flight` må behandles som timing-avhengig.

## WaitIO etablerer completion

Uansett om requesten allerede er ferdig eller fortsatt kjører, kaller vi:

```text
WaitIO(request)
```

Etter at `WaitIO()` returnerer, er requesten ferdig og kan igjen behandles som lokal ressurs.

```text
SendIO
   |
   v
IN FLIGHT
   |
 CheckIO   optional observation
   |
 WaitIO
   |
   v
COMPLETE
```

## Ingen cleanup mens requesten er aktiv

Vi må ikke gjøre dette etter `SendIO()` og før completion:

```text
CloseDevice(request)
DeleteIORequest(request)
DeleteMsgPort(port)
```

Devicen kan fortsatt bruke requesten og reply-porten.

Først etter `WaitIO()` kan cleanup fortsette.

## Eksempel

Se `examples/28-device-async/timer-async.e`.

Den stabile sluttlinjen er:

```text
timer request complete
```

Qualification-casen låses først etter faktisk E-VO 3.9.4-kompilering og amiga-runtime-kjøring. Timing-avhengig `CheckIO()`-tekst må ikke brukes som eneste forventet stdout.

## Cancellation

Hva hvis programmet må avslutte før requesten fullfører? Da er ikke `DeleteIORequest()` løsningen.

Riktig mønster er:

```text
AbortIO(request)
WaitIO(request)
```

Upstream E-VO 3.9.4s `extra_examples/clock.e` bruker nettopp denne sekvensen når programmet avslutter med en aktiv timer-request. Dette blir neste leksjon.

## Oppsummering

`SendIO()` gjør requesten in flight. `CheckIO()` kan observere completion uten å blokkere. `WaitIO()` etablerer at operasjonen virkelig er ferdig før request, device og port kan ryddes bort.
