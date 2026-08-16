{ lib, python313, fetchFromGitHub }:

python313.pkgs.buildPythonApplication {
  pname = "newman";
  version = "0.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "lukebodmer";
    repo = "newman";
    rev = "c57a97f3f22a9f0c0cf61fca15b2901711b3c0f5";
    sha256 = "sha256-yAQJdJaIL/P6Z/2mPFt5Qmp57OP0Qs1zCxsHUzyDX38=";
  };

  build-system = [ python313.pkgs.setuptools ];
  dependencies = [ python313.pkgs.rich python313.pkgs.httpx python313.pkgs.trafilatura python313.pkgs.pypdf python313.pkgs.prompt-toolkit python313.pkgs.websockets ];

  meta = with lib; {
    description = "A personal AI agent harness for the terminal";
    platforms = platforms.linux;
  };
}
