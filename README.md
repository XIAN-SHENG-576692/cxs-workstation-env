# cxs-workstation-env

cxs workstation environment.

## Installation

```bash
git clone --filter=tree:0 --depth=1 --no-tags \
https://github.com/XIAN-SHENG-576692/cxs-workstation-env.git
```

## File Structure

- `containers/`: Some scripts used to manipulate containers.
- `dev/`: Some scripts for developer.
- `init/`: Some scripts used to initialize the workstation environment.
- `install_vscode_extensions/`: Some scripts are used to install VS Code extensions to make working in a workstation environment easier.
- `scripts/`: Some scripts.

## Usage

### Containers

```shell
./containers/run.sh
./containers/exec.sh
```

```shell
./containers/rm.sh
```

### Init

```shell
./init/init_c_dev_env.sh
./init/init_latex_dev_env.sh
./init/init_lean4_dev_env.sh
./init/init_rust_dev_env.sh
./init/init_typst_dev_env.sh -p <INSTALL_PATH>
./init/install_cargo-binstall.sh
./init/install_codex.sh
./init/install_common_packages.sh
```
