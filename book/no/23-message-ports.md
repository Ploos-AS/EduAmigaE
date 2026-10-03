# Exec message ports

## Mål

Etter denne leksjonen skal du kunne opprette en Exec message port, hente portens signalmaske og avslutte portens levetid uten å frigjøre interne ressurser separat.

## En port kombinerer kø og signal

En message port er mer enn et signal. Den knytter sammen en meldingskø med mekanismen som varsler tasken når arbeid er tilgjengelig.

E-VO 3.9.4 definerer `OBJECT mp` i `exec/ports`. Strukturen inneholder blant annet:

```text
sigbit
sigtask
msglist
```

Dette viser de to sentrale sidene av porten: hvem som skal varsles, og køen med meldinger.

## Acquire og release

Exec FD-en definerer:

```text
CreateMsgPort()
DeleteMsgPort(port)
```

Dette er ressurs-paret vi bruker. Dersom `CreateMsgPort()` lykkes, eier programmet porten og skal senere kalle `DeleteMsgPort()`.

## Portens signalbit

Porten har allerede et `sigbit`. E-VO 3.9.4s eget `extra_examples/clock.e` lager signalmasken slik:

```text
timer_sig := Shl(1, msg.sigbit)
```

Kurseksemplet gjør tilsvarende:

```text
portMask := Shl(1, port.sigbit)
```

Men dette betyr **ikke** at programmet skal kalle `FreeSignal(port.sigbit)`. Signaloppsettet er en del av ressursen som `CreateMsgPort()` opprettet og som `DeleteMsgPort()` avslutter.

Dette er kompositt-eierskap: én høyere ressurs kan eie flere interne ressurser.

## Eksempel

Se `examples/23-message-port/create-port.e`.

På suksessbanen forventer vi:

```text
message port ready
```

Vi skriver ikke signalbitnummeret fordi det kan variere mellom kjøringer.

Qualification-casen låses først etter faktisk E-VO 3.9.4-kompilering og amiga-runtime-kjøring.

## Veien videre

Nå har vi en port som kan varsle tasken. Neste steg er selve protokollen: meldingsstrukturen, `PutMsg()`, `WaitPort()`, `GetMsg()` og `ReplyMsg()`.

## Oppsummering

`CreateMsgPort()` oppretter en port med kø og signalintegrasjon. Bruk `mp.sigbit` til å bygge en ventemaske, men la `DeleteMsgPort()` rydde opp portens interne ressurser.
