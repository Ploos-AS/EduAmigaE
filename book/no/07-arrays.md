# 07 — Arrays

## Mål

Lære å lagre flere verdier under ett navn og hente dem med en indeks.

## Eksempel

```e
PROC main()
  DEF values[5]:ARRAY, i
  values[0] := 2
  values[1] := 4
  values[2] := 6
  values[3] := 8
  values[4] := 10

  FOR i := 0 TO 4
    WriteF('\d\n', values[i])
  ENDFOR
ENDPROC
```

**Kompatibilitet:** E33.

Arrayet har fem elementer. Indeksene er 0 til 4. Løkken gjør at samme kode kan behandle hvert element.

## Kjør og endre

```sh
eduamigae build examples/07-arrays/arrays.e
eduamigae run build/arrays
```

Endre verdiene og beregn summen av alle elementene.

## Tenk

Hvorfor er siste gyldige indeks 4 når arrayet inneholder fem elementer? Hva kan skje dersom kode bruker en indeks utenfor området?

## Øvelse

Lag et array med fem egne tall og skriv dem i motsatt rekkefølge.

## Utfordring

Finn den største verdien i arrayet ved hjelp av en løkke og en variabel som holder beste verdi så langt.

## Oppsummering

Arrays samler flere elementer av samme slags data og gjør løkker langt mer nyttige. Indekser og grenser blir særlig viktige når vi senere arbeider nærmere minnet.
