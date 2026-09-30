# 08 — Strukturer med OBJECT

## Mål

Lære å samle relaterte verdier med forskjellige betydninger i én navngitt datastruktur.

## Eksempel

```e
OBJECT point
  x, y
ENDOBJECT

PROC main()
  DEF p:point
  p.x := 10
  p.y := 20
  WriteF('point=\d,\d\n', p.x, p.y)
ENDPROC
```

**Kompatibilitet:** E33.

I E brukes `OBJECT` både som grunnlag for objektorientering og som en praktisk strukturtype. Her bruker vi bare struktur-delen. `point` beskriver formen på dataene, mens `p` er en variabel av denne typen.

Feltene nås med punktum: `p.x` og `p.y`.

## Kjør og endre

```sh
eduamigae build examples/08-objects/objects.e
eduamigae run build/objects
```

Legg til feltet `z`, gi det en verdi og skriv alle tre koordinatene.

## Tenk

Et array samler mange elementer med samme rolle. Et OBJECT kan gi hvert felt eget navn og egen betydning. Når passer den ene modellen bedre enn den andre?

## Øvelse

Definer `OBJECT rectangle` med feltene `width` og `height`. Beregn arealet til en variabel av typen.

## Utfordring

Lag en prosedyre som mottar en `PTR TO point` senere når pointer-kapitlet er gjennomført. Foreløpig: lag to `point`-variabler og beregn forskjellen mellom koordinatene.

## Oppsummering

`OBJECT` gir strukturerte data. Dette er også fundamentet for E sin objektmodell og for mange AmigaOS-strukturer, men metoder, arv, dynamisk allokering og pointers kommer senere.
