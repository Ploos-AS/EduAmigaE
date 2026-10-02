# Exec og gjeldende task

## Mål

Etter denne leksjonen skal du kunne forklare hva en Exec-task representerer, hente pekeren til gjeldende task og skille mellom å observere en eksisterende OS-struktur og å eie en ressurs som skal frigjøres.

## Execution context

Exec planlegger arbeid i tasks. Programmet vårt kjører allerede i en execution context når `main()` begynner. Vi trenger derfor ikke opprette en ny task for å undersøke den vi allerede kjører i.

E-VO 3.9.4s Exec-definisjon inneholder:

```text
FindTask(name)
```

og upstream-eksemplet `extra_examples/tasklist.e` bruker:

```text
task := FindTask(NIL)
```

for å hente gjeldende task.

## Task-strukturen

Modulen `exec/tasks` definerer `OBJECT tc`. Den inneholder blant annet nodeinformasjon, state og signalfeltene `sigalloc`, `sigwait`, `sigrecvd` og `sigexcept`.

Kurseksemplet bruker en typet peker:

```text
DEF task:PTR TO tc
```

Dette kobler pointer-kunnskapen fra M3 direkte til en ekte operativsystemstruktur.

## Lånt peker, ikke eid ressurs

Pekeren fra `FindTask(NIL)` beskriver en task som Exec allerede administrerer. Eksemplet har ikke allokert tasken og skal derfor heller ikke forsøke å frigjøre den.

Dette gir en viktig ny eierskapskategori:

```text
owned resource  -> release it
borrowed pointer -> do not release it
```

Å ha en peker betyr altså ikke automatisk at programmet eier objektet den peker på.

## Eksempel

Se `examples/20-exec-task/current-task.e`. Programmet kontrollerer pekeren og skriver en deterministisk statuslinje i stedet for task-navn eller adresse, fordi slike detaljer kan variere mellom runtime-profiler.

Qualification-casen låses først etter E-VO 3.9.4-kompilering og amiga-runtime-kjøring.

## Oppsummering

`FindTask(NIL)` lar oss observere gjeldende Exec-task. Pekeren er lånt fra operativsystemet, ikke en ressurs vi skal frigjøre.
