# Lese filer og fullføre livsløpet

## Mål

Etter denne leksjonen skal du kunne bruke et DOS-filhåndtak i flere separate faser og forstå at hver vellykket `Open()` oppretter et nytt eierskap.

## To forskjellige ressurser

Eksemplet `examples/19-dos-read/read-file.e` oppretter først en fil med `MODE_NEWFILE`, skriver kjent tekst og lukker håndtaket. Deretter åpner det samme filnavnet med `MODE_OLDFILE`.

Dette er ikke ett langt eierskap. Det er to:

```text
Open for write -> Write -> Close
Open for read  -> Read  -> Close
```

Etter den første `Close()` er det første håndtakets levetid slutt. Den andre `Open()` må lykkes før det finnes et nytt håndtak å lese fra.

## Kontroller antall bytes

E-VO 3.9.4s DOS-definisjon er `Read(file, buffer, length)`. Upstream-eksemplene kontrollerer at returverdien er lik antallet bytes de forventet å lese.

Kurseksemplet gjør det samme. Først når `Read()` returnerer hele lengden, terminerer vi bufferen med null og skriver teksten med `WriteF()`.

## Buffergrensen

Bufferen har 32 bytes, mens eksemplet leser en kort, kjent tekst. Plassen ved `buffer[length]` brukes til nullterminatoren etter lesingen.

I senere kode der filstørrelsen kommer utenfra må bufferstørrelse og lesegrenser behandles som egne sikkerhetskrav.

## Cleanup ved feil

Legg merke til at hvert vellykket `Open()` har sin egen `Close()`, også dersom den påfølgende `Write()` eller `Read()` ikke gir forventet resultat.

Det er ressursmodellen fra kapittel 17 anvendt to ganger etter hverandre.

## Qualification

Eksemplet forventes å skrive:

```text
read=EduAmigaE
```

Casen låses først etter faktisk E-VO 3.9.4-kompilering og amiga-runtime-kjøring.

## Oppsummering

Et filnavn er ikke det samme som et åpent filhåndtak. Hver vellykket `Open()` starter et nytt ressursliv som avsluttes med sin egen `Close()`.
