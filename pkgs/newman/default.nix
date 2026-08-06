{ lib, python313 }:

python313.pkgs.buildPythonApplication {
  pname = "newman";
  version = "0.1.0";
  pyproject = true;

  # Development: use local path for fast iteration.
  # Release: switch to fetchFromGitHub and run:
  #   nix flake prefetch "github:lukebodmer/newman/<commit-sha>"
  # then set rev and sha256, push custom_nixpkgs, and run
  #   nix flake update custom-nixpkgs  (in system/nixos)
  src = /home/lj/projects/newman;

  build-system = [ python313.pkgs.setuptools ];
  dependencies = [ python313.pkgs.rich python313.pkgs.httpx ];

  meta = with lib; {
    description = "A personal AI agent harness for the terminal";
    platforms = platforms.linux;
  };
}
