# 09 — Moduler

## Mål

Forstå hvorfor E bruker moduler, hvordan et program importerer en modul, og hvordan en modul-kilde skiller offentlig grensesnitt fra implementasjon.

## Importere en modul

```e
MODULE 'exec/types'

PROC main()
  WriteF('module import ok\n')
ENDPROC
```

**Kompatibilitet:** E33.

`MODULE` gjør deklarasjoner fra en modul tilgjengelige for kildekoden. Modulnavnet er ikke en privat Ploos-avhengighet; eksemplet bruker en standard modul fra Amiga E/E-VO-miljøet.

```sh
eduamigae build examples/09-modules/modules.e
eduamigae run build/modules
```

## Hvordan en modul-kilde ser ut

Klassiske Amiga E-modulkilder bruker denne formen:

```e
OPT MODULE
OPT EXPORT

/* deklarasjoner og kode som modulen eksporterer */
```

En modul kan også bruke `MODULE '...'` for egne avhengigheter. Det betyr at større E-programmer kan deles opp i lag i stedet for å samle all kode i én fil.

Bygging av egne `.m`-moduler behandles senere sammen med toolchain og større prosjektstruktur. Vi later ikke som en vanlig programkompilering er det samme som modulbygging.

## Tenk

Hva er forskjellen mellom å kopiere samme deklarasjon inn i ti kildefiler og å importere én modul?

## Øvelse

Finn tre standardmoduler i E-VO-distribusjonens `Modules`-tre og noter hva navnene forteller om subsystemet de tilhører.

## Utfordring

Skisser et program med tre egne ansvarsområder og foreslå hvordan de kunne deles i moduler. Ingen kode er nødvendig ennå.

## Oppsummering

Moduler er E sin mekanisme for gjenbruk og organisering på tvers av kildefiler. Senere bruker vi dem tungt når vi går inn i AmigaOS-API-ene.
