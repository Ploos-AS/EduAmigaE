# 03 — Valg med IF

## Mål

Lære å la programmet velge mellom alternative handlinger.

## Eksempel

```e
PROC main()
  DEF value
  value := 42
  IF value > 10
    WriteF('large\n')
  ELSE
    WriteF('small\n')
  ENDIF
ENDPROC
```

**Kompatibilitet:** E33.

Sammenligningen `value > 10` gir betingelsen. Når den er sann kjøres første gren; ellers kjøres `ELSE`-grenen.

## Kjør og endre

```sh
eduamigae build examples/03-control-flow/control-flow.e
eduamigae run build/control-flow
```

Prøv verdiene 10, 11 og -1. Bytt deretter `>` med en annen sammenligning.

## Flere valg med SELECT

Når én verdi skal sammenlignes med flere konkrete alternativer, kan `SELECT` være tydeligere enn en lang kjede med `IF`:

```e
PROC main()
  DEF value
  value := 2
  SELECT value
  CASE 1; WriteF('one\n')
  CASE 2; WriteF('two\n')
  CASE 3; WriteF('three\n')
  ENDSELECT
ENDPROC
```

Kilde: `examples/03-control-flow/select.e`. Dette mønsteret er også brukt i E-VO 3.9.4-kildene.

## Tenk

Hva skjer akkurat på grensen 10? Hvorfor er grenseverdier viktige når programmer testes?

## Øvelse

Skriv et program som skriver `positive` når et tall er større enn null og `not positive` ellers.

## Utfordring

Utvid programmet til tre tilfeller: negativ, null og positiv.

## Oppsummering

Kontrollflyt lar data påvirke hvilke instruksjoner som utføres. Neste steg er repetisjon med løkker.
