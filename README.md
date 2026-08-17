# HelloWorld

A portable C Hello World program with GitHub Actions builds for modern desktop,
Raspberry Pi, and 16-bit DOS targets.

## Build targets

| Release asset | Target environment | Build environment |
| --- | --- | --- |
| `HelloWorld-windows64.exe` | Windows x64 | MSBuild on Windows Server 2022 |
| `HelloWorld-linux64` | Linux x86-64 | GCC on Ubuntu 24.04 |
| `HelloWorld-raspberrypi32` | 32-bit Raspberry Pi OS | GCC inside `pguyot/arm-runner-action` |
| `HelloWorld-raspberrypi64` | 64-bit Raspberry Pi OS | GCC inside `pguyot/arm-runner-action` |
| `HelloWorld-dos16.exe` | 16-bit DOS | Turbo C++ 3.00 inside DOSBox-X |

Every build executes the resulting program and checks that it prints
`Hello world`. Linux and emulated builds also check the executable format and
architecture before uploading the artifact.

## GitHub Releases

The workflow builds on pushes and pull requests to `main`, and it can be run
manually from the Actions tab. Those runs retain each binary as a workflow
artifact for seven days.

Pushing a new tag beginning with `v` also creates a GitHub Release containing
all five binaries and `SHA256SUMS.txt`:

```sh
git tag v1.1.0
git push origin v1.1.0
```

Use a new tag for each release. The existing `v1.0.0` tag predates this
workflow and is not moved or rebuilt automatically.

## DOS build dependency

The DOS build uses
[`joncloud/dos-build-action@v1`](https://github.com/joncloud/dos-build-action),
which bundles Borland Turbo C++ 3.00 and runs it in DOSBox-X. The workflow pins
the action to its immutable release commit and DOSBox-X to Snap revision 1502
(version 2026.01.02). The action uses the legacy Node 16 GitHub Actions runtime
and includes third-party compiler binaries, so review its compatibility and
licensing before redistributing anything beyond the generated
`HelloWorld-dos16.exe`.
