{ lib,
  fetchPypi,
  buildPythonPackage,
  poetry-core,
  numpy,
  pandas,
  requests
}:

buildPythonPackage rec {
  pname = "nba_api";
  version = "1.11.4";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-HczXC3jzb2QmDh81PEoCwWRBR8Sipc5C+9n2N9cLrT4=";
  };

  build-system = [ poetry-core ];

  dependencies = [
    numpy
    pandas
    requests
  ];

  doCheck = false;

  pythonImportsCheck = [ "nba_api" ];

  meta = with lib; {
    description = "API client for programmatic access to NBA.com data endpoints";
    homepage = "https://github.com/swar/nba_api";
    license = licenses.mit;
  };
}
