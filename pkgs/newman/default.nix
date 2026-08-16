{ lib, python313, fetchFromGitHub }:

python313.pkgs.buildPythonApplication {
  pname = "newman";
  version = "0.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "lukebodmer";
    repo = "newman";
    rev = "3398e124e2b352352d0097556b4988fa91a7b7a3";
    sha256 = "sha256-RuCbLHOHxu3EviYKR0hN8uOojtdGY9wMZ8rgqCrsk/4=";
  };

  build-system = [ python313.pkgs.setuptools ];
  dependencies = [ python313.pkgs.rich python313.pkgs.httpx python313.pkgs.trafilatura python313.pkgs.pypdf python313.pkgs.prompt-toolkit python313.pkgs.websockets ];

  meta = with lib; {
    description = "A personal AI agent harness for the terminal";
    platforms = platforms.linux;
  };
}
