# 05 — Prosedyrer og parametere

## Mål

Lære å dele et program i navngitte deler, sende data inn som parametere og returnere et resultat.

## Eksempel

```e
PROC square(value)
  RETURN value * value
ENDPROC

PROC main()
  DEF result
  result := square(7)
  WriteF('square=\d\n', result)
ENDPROC
```

**Kompatibilitet:** E33.

`square` beskriver én oppgave. Parameteren `value` får argumentet fra kallet. `RETURN` sender resultatet tilbake til uttrykket som kalte prosedyren.

## Kjør og endre

```sh
eduamigae build examples/05-procedures/procedures.e
eduamigae run build/procedures
```

Prøv andre argumenter. Lag deretter en prosedyre `double(value)`.

## Tenk

Hvorfor er `square(7)` nyttigere enn å skrive `7*7` overalt i et større program?

## Øvelse

Lag `add(a,b)` som returnerer summen av to parametere.

## Utfordring

Lag små prosedyrer for areal og omkrets av et rektangel og kall begge fra `main`.

## Oppsummering

Prosedyrer gir kode navn, grenser og gjenbruk. Parametere flytter data inn; returverdier flytter resultater ut. Neste steg er samlinger av data: strenger og arrays.
