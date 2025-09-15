{ lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  hatchling
}:

buildPythonPackage rec {
  pname = "trame_common";
  version = "1.0.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-nUry2abQinQFl39FmTHKudS1OuEgqAJkVF9nnR+alLw=";
  };

  build-system = [
    setuptools
    hatchling
  ];

  propagatedBuildInputs = [
  ];

  doCheck = false;
  pythonImportsCheck = [ "trame_common" ];

  meta = with lib; {
    description = "server implementation of trame";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
}

