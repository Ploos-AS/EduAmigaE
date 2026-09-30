# 04 — Løkker

## Mål

Lære å gjenta kode kontrollert og forstå løkkevariabel, startverdi og sluttbetingelse.

## Eksempel

```e
PROC main()
  DEF i
  FOR i := 1 TO 5
    WriteF('\d\n', i)
  ENDFOR
ENDPROC
```

**Kompatibilitet:** E33.

`FOR` gir en tydelig løkke når vi kjenner området på forhånd. Her får `i` verdiene 1 til 5, og kroppen kjøres én gang for hver verdi.

## Kjør og endre

```sh
eduamigae build examples/04-loops/loops.e
eduamigae run build/loops
```

Endre sluttverdien. Prøv deretter å bruke `i` i et uttrykk inne i løkken.

## Tenk

Hvor mange ganger kjøres kroppen fra 1 til 5? Hva er siste verdi som faktisk brukes?

## Øvelse

Skriv tallene 1 til 10 og kvadratet av hvert tall.

## Utfordring

Bruk en variabel som akkumulator og beregn summen av tallene 1 til 10.

## Oppsummering

Løkker gjør repetisjon eksplisitt. Sammen med IF kan de beskrive mye av kontrollflyten i små programmer. Neste kapittel flytter gjenbrukbar logikk inn i prosedyrer.
