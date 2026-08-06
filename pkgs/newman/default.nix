{ lib, python313, fetchFromGitHub }:

python313.pkgs.buildPythonApplication {
  pname = "newman";
  version = "0.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "lukebodmer";
    repo = "newman";
    rev = "6d85cf63e0f11159060672c1bf308d78cf1ef7ee";
    sha256 = "sha256-CM5JpcCPaCx3zexTvVFCb9X7N65UXxZ8O1CqKHeSOI0=";
  };

  build-system = [ python313.pkgs.setuptools ];
  dependencies = [ python313.pkgs.rich python313.pkgs.httpx ];

  meta = with lib; {
    description = "A personal AI agent harness for the terminal";
    platforms = platforms.linux;
  };
}
