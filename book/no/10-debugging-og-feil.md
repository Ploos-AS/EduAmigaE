# 10 — Debugging og feil

## Mål

Lære å skille mellom kompileringsfeil, runtime-feil og logiske feil, og bruke en systematisk arbeidsmåte for å finne dem.

## Tre typer feil

**Kompileringsfeil** oppdages før programmet kan kjøres. Eksempler er ugyldig syntaks eller navn kompilatoren ikke kjenner.

**Runtime-feil** oppstår mens programmet kjører. Senere i kurset blir ugyldige pointers, feil ressursbruk og OS-kall viktige eksempler.

**Logiske feil** betyr at programmet kjører, men gir feil resultat. Disse er ofte vanskeligst fordi kompilatoren ikke nødvendigvis kan hjelpe.

## En enkel metode

1. Gjør problemet reproducerbart.
2. Reduser problemet til minst mulig kode.
3. Kontroller antakelser med små utskrifter.
4. Test grenseverdier.
5. Endre én ting om gangen.
6. Kjør samme test på nytt.
7. Behold en regression-test når feilen er rettet.

Qualification-casene i EduAmigaE følger samme idé: kjent kildekode, kjent forventet output og eksplisitte runtime-profiler.

## Praktisk øvelse

Ta array-eksemplet fra kapittel 07. Endre én verdi slik at forventet sum i din egen beregning blir feil. Finn feilen ved å skrive indeks og verdi inne i løkken.

## Bug-jakt

Lag med vilje tre kopier av et tidligere eksempel:

- én som ikke kompilerer,
- én som kompilerer men har feil beregning,
- én som feiler først for en bestemt grenseverdi.

Beskriv hvordan du identifiserte hver feiltype.

## Oppsummering

Debugging er ikke tilfeldig prøving. Det er en kontrollert prosess der hypoteser testes mot observerbar oppførsel. Denne vanen blir avgjørende når kurset går videre til pointers, minne og AmigaOS.
