{ pkgs, ...}:

let
  flakeNixContent = builtins.readFile ./dev_flake.nix;
  envrcContent = builtins.readFile ./dev_envrc;
in
pkgs.writeShellScriptBin "dev-env" ''
  printf '%s\n' '${flakeNixContent}' > flake.nix
  printf '%s\n' '${envrcContent}' > .envrc
  printf '%s\n' '.envrc\n.direnv/' > .gitignore
  direnv allow
''
