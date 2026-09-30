# EduAmigaE student OCI

The student image contains the open host-side environment needed by the course. It deliberately does **not** contain E-VO, Kickstart, Workbench or commercial AmigaOS files.

## Included

- Debian slim base
- Python
- amitools / vamos
- EduAmigaE compile adapter
- minimal open vamos configuration
- environment self-test

## External input

Mount or import a legally obtained E-VO 3.9.4 distribution at:

```text
/toolchains/evo/3.9.4
```

The image sets `EVO_HOME` to that path.

## Build

```sh
docker build -f student/Dockerfile -t eduamigae-student .
```

## Check the open environment

```sh
docker run --rm eduamigae-student -c eduamigae-self-test
```

This succeeds without E-VO and reports it as not provisioned.

## Use a local E-VO installation

```sh
docker run --rm -it \
  -v "$PWD:/course" \
  -v "/path/to/evo-3.9.4:/toolchains/evo/3.9.4:ro" \
  eduamigae-student
```

The course repository is mounted separately from the toolchain. This keeps course material redistributable and makes third-party provenance visible.
