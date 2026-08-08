{ lib, python313, fetchFromGitHub }:

python313.pkgs.buildPythonApplication {
  pname = "newman";
  version = "0.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "lukebodmer";
    repo = "newman";
    rev = "9a11d7c85fac22ac6b0b78d1101e5a81e520b538";
    sha256 = "sha256-o3/KS04T66fF1DEMFCqHNV0hAsnpt6D3MM+Nnl1Tlyk=";
  };

  build-system = [ python313.pkgs.setuptools ];
  dependencies = [ python313.pkgs.rich python313.pkgs.httpx python313.pkgs.trafilatura python313.pkgs.pypdf ];

  meta = with lib; {
    description = "A personal AI agent harness for the terminal";
    platforms = platforms.linux;
  };
}
