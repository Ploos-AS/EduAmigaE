# Exec-signaler

## Mål

Etter denne leksjonen skal du kunne skille mellom et signalnummer og en signalmaske, og forklare hvordan signaler passer inn i Exec sin ventemodell.

## Signalnummer og signalmaske

Exec bruker signalbits til å varsle tasks om hendelser. To verdier må holdes fra hverandre:

- et **signalnummer** identifiserer hvilken bit som brukes
- en **signalmaske** er bitverdien som sendes til operasjoner som `Wait()` og `Signal()`

E-VO 3.9.4s Exec FD definerer blant annet:

```text
Wait(signalSet)
Signal(task, signalSet)
AllocSignal(signalNum)
FreeSignal(signalNum)
```

Et upstream E-VO-eksempel bygger masker fra signalbits slik:

```text
mask := Shl(1, sigbit)
```

Det betyr at signalbit 5 og masken for signalbit 5 ikke er samme tall: bitnummeret er 5, mens masken har bit 5 satt.

## Fra polling til venting

Tidligere eksempler har kjørt sekvensielt. Med `Wait(mask)` kan en task i stedet vente til en av de valgte signalbitene blir satt.

Dette blir grunnlaget for senere event loops:

```text
event source -> signal bit -> Wait(mask) -> handle event
```

## Eierskap

`AllocSignal()` og `FreeSignal()` danner et ressurspar når programmet selv reserverer en signalbit. Et signalbit-felt som allerede tilhører en annen OS-ressurs, for eksempel en message port, skal derimot behandles etter eierskapsreglene til den ressursen.

Vi lager ikke et `AllocSignal()`-qualification-eksempel ennå. FD-en verifiserer funksjonssignaturene, men før kurset lærer en konkret feiltest skal returkontrakten verifiseres eksplisitt mot autoritativ API-dokumentasjon eller et kvalifisert toolchain/runtime-resultat.

## Upstream-eksempel

E-VO 3.9.4s `extra_examples/clock.e` bruker blant annet:

```text
intui_sig := Shl(1, win.userport.sigbit)
timer_sig := Shl(1, msg.sigbit)
```

Dette er akkurat skillet vi trenger før message ports og event loops.

## Oppsummering

Signalnummeret velger en bit. Signalmasken representerer biten i et sett. Hold de to begrepene adskilt før du bruker `Wait()`, `Signal()` eller message ports.
