{ lib,
  buildPythonPackage,
  more-itertools,
  fetchPypi,
  setuptools,
}:

buildPythonPackage rec {
  pname = "trame-server";
  version = "3.6.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-iLhhFiy4sCXoTpPxfc/UOoTQLSwWCMn21Y481kalDAU=";
  };

  build-system = [
    setuptools
  ];

  propagatedBuildInputs = [
    more-itertools
  ];

  doCheck = false;
  pythonImportsCheck = [ "trame" ];

  meta = with lib; {
    description = "open-source platform for creating interactive and powerful visual analytics applications";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
}

