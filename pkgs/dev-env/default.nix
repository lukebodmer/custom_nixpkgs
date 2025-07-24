{ pkgs,
  ...}:

let
  flakeNixContent = builtins.readFile ./dev_flake.nix;
  envrcContent = builtins.readFile ./dev_envrc;
in
pkgs.writeShellScriptBin "dev-env" ''
  cat <<'EOF' > flake.nix
    ${flakeNixContent}
  EOF
  cat <<'EOF' > .envrc
    ${envrcContent}
  EOF
  cat <<'EOF' > .gitignore
.envrc
.direnv/
  EOF
  direnv allow
''
