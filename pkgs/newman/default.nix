{ lib, python313, fetchFromGitHub }:

python313.pkgs.buildPythonApplication {
  pname = "newman";
  version = "0.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "lukebodmer";
    repo = "newman";
    rev = "6e4fea89405d2c46b55b8d01a6abd06c30b5f533";
    sha256 = "sha256-N9/D8h4D0jlicAWShjkvICHZKFmpzM9XsO3DuPZzV9M=";
  };

  build-system = [ python313.pkgs.setuptools ];
  dependencies = [ python313.pkgs.rich python313.pkgs.httpx python313.pkgs.trafilatura python313.pkgs.pypdf python313.pkgs.prompt-toolkit python313.pkgs.websockets ];

  meta = with lib; {
    description = "A personal AI agent harness for the terminal";
    platforms = platforms.linux;
  };
}
