{ lib, python313, fetchFromGitHub }:

python313.pkgs.buildPythonApplication {
  pname = "newman";
  version = "0.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "lukebodmer";
    repo = "newman";
    rev = "e6ad14f64a1ae2c865c4b1f10e0d111ba9472b7b";
    sha256 = "sha256-2OhaRmN4vJXCN5eUrzgmGkFIH78j7G/sk7DqO0rFTRA=";
  };

  build-system = [ python313.pkgs.setuptools ];
  dependencies = [ python313.pkgs.rich python313.pkgs.httpx python313.pkgs.trafilatura python313.pkgs.pypdf python313.pkgs.prompt-toolkit python313.pkgs.websockets ];

  meta = with lib; {
    description = "A personal AI agent harness for the terminal";
    platforms = platforms.linux;
  };
}
