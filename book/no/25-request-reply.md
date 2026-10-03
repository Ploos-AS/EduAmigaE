# Request/reply med Exec-meldinger

## Mål

Etter denne leksjonen skal du kunne følge eierskapet til en melding gjennom hele request/reply-protokollen og forklare hvorfor senderen må vente på svaret før meldingsminnet kan gjenbrukes eller frigjøres.

## To porter, to retninger

En request/reply-utveksling trenger et sted å sende requesten og et sted å returnere den ferdigbehandlede meldingen.

Eksemplet oppretter derfor:

```text
requestPort
replyPort
```

Meldingshodet peker tilbake til senderens reply-port:

```text
message.replyport := replyPort
```

## Hele livsløpet

Protokollen er:

```text
sender owns message
        |
        v
PutMsg(requestPort, message)
        |
        v
request in flight
        |
        v
receiver: GetMsg(requestPort)
        |
        v
ReplyMsg(message)
        |
        v
reply in flight
        |
        v
sender: GetMsg(replyPort)
        |
        v
sender owns message again
```

Først etter siste `GetMsg()` kan senderen trygt gjenbruke eller frigjøre meldingsminnet.

## ReplyMsg bruker replyport

Mottakeren trenger ikke kjenne senderens port separat. `ReplyMsg()` bruker reply-porten som allerede ligger i meldingshodet.

Dette er et viktig AmigaOS-mønster: requesten bærer informasjonen som trengs for å returnere den til eieren.

## Samme task, ekte protokoll

Undervisningseksemplet kjører begge rollene sekvensielt i samme task. Det gjør kjøringen deterministisk, men selve meldingslivsløpet er det samme som når sender og mottaker er forskjellige tasks eller når mottakeren er en OS-tjeneste.

## Cleanup

Begge porter må eksistere mens meldingen kan være på vei. Derfor slettes de først etter at reply-meldingen er hentet.

Meldingen frigjøres også først etter at replyen er tilbake hos senderen.

Dette gir en generell regel:

> Ressurser som en in-flight-operasjon refererer til må leve minst like lenge som operasjonen.

## Eksempel

Se `examples/25-exec-reply/request-reply.e`.

Forventet suksessoutput:

```text
message replied
```

Qualification-casen låses først etter faktisk E-VO 3.9.4-kompilering og amiga-runtime-kjøring.

## Veien videre

Request/reply-modellen er direkte relevant for Amiga devices. En I/O request inneholder et meldingshode og fullfører asynkront gjennom den samme typen port- og signalmekanisme.

## Oppsummering

`PutMsg()` sender eierskapet ut i protokollen. `ReplyMsg()` returnerer meldingen via `replyport`. Senderen får først kontroll over meldingsminnet tilbake når replyen er hentet fra reply-porten.
