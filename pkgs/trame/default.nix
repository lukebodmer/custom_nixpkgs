{ lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  setuptools_scm,
  wheel,
}:

buildPythonPackage rec {
  pname = "trame";
  version = "3.12.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-u7SVcQLbQbyZrXLCM7zpL50f2RvjUvwHh4xDYQM6QB8=";
  };

  build-system = [
    setuptools
    setuptools_scm
    wheel
  ];

  propagatedBuildInputs = [
  ];

  doCheck = false;
  pythonImportsCheck = [ "trame" ];

  meta = with lib; {
    description = "open-source platform for creating interactive and powerful visual analytics applications";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
}

