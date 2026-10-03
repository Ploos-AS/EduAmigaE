# Sende og motta Exec-meldinger

## Mål

Etter denne leksjonen skal du kunne legge en melding på en message port, vente på porten, hente meldingen fra køen og forklare hvem som eier meldingsminnet mens den er i køen.

## Meldingshodet

`exec/ports` definerer `OBJECT mn` med blant annet:

```text
replyport
length
```

Mange større AmigaOS-strukturer inneholder en `mn` som meldingshode. I denne første øvelsen bruker vi en ren `mn`.

## Den minste protokollen

Exec FD-en definerer:

```text
PutMsg(port, message)
GetMsg(port)
WaitPort(port)
ReplyMsg(message)
```

Dette kapittelet bruker de tre første:

```text
PutMsg(port, message)
WaitPort(port)
received := GetMsg(port)
```

`PutMsg()` legger meldingen i portens kø og varsler portens task. `WaitPort()` venter til porten har en melding. `GetMsg()` fjerner én melding fra køen og returnerer pekeren.

## In-flight ownership

Eksemplet allokerer meldingen med `NEW message`. Programmet eier minnet, men etter `PutMsg()` må det behandle meldingen som **in flight**.

```text
NEW
 |
 v
owned by sender
 |
PutMsg
 |
 v
in flight / queued
 |
GetMsg
 |
 v
owned locally again
 |
END
```

Meldingsminnet må ikke frigjøres eller gjenbrukes mens meldingen fortsatt ligger i portens kø.

I vårt lille eksempel er sender og mottaker samme program. Derfor kan vi hente den samme meldingen tilbake og deretter frigjøre den.

## Ingen ReplyMsg ennå

Vi setter:

```text
message.replyport := NIL
```

Denne meldingen har altså ingen reply-protokoll. Det er bevisst. I neste leksjon gir vi senderen en reply-port og følger hele request/reply-livsløpet med `ReplyMsg()`.

## Drener køen før porten slettes

Porten slettes først etter at meldingen er hentet med `GetMsg()`. Å slette en port mens meldinger fortsatt er i køen ville etterlate uavklart eierskap.

## Eksempel

Se `examples/24-exec-message/send-message.e`.

Forventet suksessoutput:

```text
message received
```

Qualification-casen låses først etter faktisk E-VO 3.9.4-kompilering og amiga-runtime-kjøring.

## Oppsummering

`PutMsg()` overfører en melding til en portkø. `WaitPort()` venter på køaktivitet, og `GetMsg()` tar meldingen ut igjen. Mellom `PutMsg()` og `GetMsg()` må meldingen behandles som in flight.
