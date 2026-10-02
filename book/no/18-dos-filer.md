# DOS-filer og håndtak

## Mål

Etter denne leksjonen skal du kunne åpne en fil med DOS, kontrollere filhåndtaket, skrive data og lukke filen på riktig sted.

## DOS som ressurs-API

En åpen fil er en ressurs med en tydelig levetid. E-VO 3.9.4s DOS-definisjoner gir blant annet:

```text
Open(name, accessMode)
Write(file, buffer, length)
Close(file)
```

Modulen `dos/dos` definerer blant annet `MODE_NEWFILE`.

## Acquire og check

Eksemplet åpner `T:eduamigae-m4.txt`:

```text
file := Open('T:eduamigae-m4.txt', MODE_NEWFILE)
```

Bare dersom `file` er gyldig går programmet videre til `Write()`. `T:` brukes fordi dette er midlertidige data, ikke en fil kurset skal etterlate permanent.

## Use og release

Programmet måler teksten med `StrLen()`, skriver nøyaktig dette antallet bytes og lagrer resultatet fra `Write()`. Deretter lukkes håndtaket med `Close(file)`.

Det er viktig at `Close()` ikke utsettes bare fordi vi også vil kontrollere skriveresultatet. Når skrivingen er ferdig, trenger vi ikke lenger det åpne håndtaket.

## Delvis feil

To feilbaner er interessante:

- `Open()` feiler: ingen filressurs ble anskaffet, så vi skal ikke kalle `Close()`.
- `Write()` skriver ikke forventet antall bytes: filen er fortsatt åpnet av oss og må derfor lukkes.

Dette er M4-modellen i praksis: cleanup bestemmes av hva vi faktisk har anskaffet, ikke av om resten av operasjonen lyktes.

## Eksempel

Se `examples/18-dos-files/write-file.e`. På suksessbanen skriver programmet `file write ok`.

Qualification-casen låses først etter kompilering med E-VO 3.9.4 og kjøring gjennom de deklarerte amiga-runtime-profilene.

## Oppsummering

DOS-filhåndtak er eide ressurser. Kontroller resultatet fra `Open()`, bruk håndtaket bare når det er gyldig, og kall `Close()` på alle baner som faktisk eier filen.
