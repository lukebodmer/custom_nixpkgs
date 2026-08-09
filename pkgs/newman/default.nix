{ lib, python313, fetchFromGitHub }:

python313.pkgs.buildPythonApplication {
  pname = "newman";
  version = "0.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "lukebodmer";
    repo = "newman";
    rev = "5f51f36759e4d589c1b58bc9c0b6be1ae33d0347";
    sha256 = "sha256-rT4wKXn9SSOhukxNx6kZcGpI7u1XsrmIlzalGKGb42I=";
  };

  build-system = [ python313.pkgs.setuptools ];
  dependencies = [ python313.pkgs.rich python313.pkgs.httpx python313.pkgs.trafilatura python313.pkgs.pypdf python313.pkgs.prompt-toolkit python313.pkgs.websockets ];

  meta = with lib; {
    description = "A personal AI agent harness for the terminal";
    platforms = platforms.linux;
  };
}
