# Minimal vamos system

The Q1 E-VO compile lane intentionally does not contain Kickstart, Workbench or proprietary AmigaOS files.

vamos provides host-side implementations of exec.library and dos.library. The EduAmigaE compile configuration locks those libraries to `mode=vamos` and disables fallback loading of arbitrary libraries.

The `system:` volume therefore starts empty. It exists only as a stable volume/assign for tools that expect the name.

This environment is suitable only for compiler qualification. It is not evidence that the generated program works on AmigaOS. Runtime evidence belongs to amiga-runtime.

## Build

```sh
scripts/prepare-vamos-env.sh
export VAMOS_CONFIG=$PWD/build/vamos-env/.vamosrc
export VAMOS_SYSTEM=$PWD/build/vamos-env/system
```

Then import E-VO 3.9.4 and invoke `scripts/compile-vamos.sh`.
