{ lib,
  buildPythonPackage,
  pyyaml,
  fetchPypi,
  setuptools,
  trame_server,
  setuptools_scm,
  wheel,
}:

buildPythonPackage rec {
  pname = "trame";
  version = "3.12.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-iLhhFiy4sCXoTpPxfc/UOoTQLSwWCMn21Y481kalDAU=";
  };

  build-system = [
    setuptools
    #setuptools_scm
    #wheel
  ];

  propagatedBuildInputs = [
    pyyaml
    trame_server
  ];

  doCheck = false;
  pythonImportsCheck = [ "trame" ];

  meta = with lib; {
    description = "open-source platform for creating interactive and powerful visual analytics applications";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
}

