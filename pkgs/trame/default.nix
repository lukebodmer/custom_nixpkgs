{ lib,
  buildPythonPackage,
  pyyaml,
  fetchPypi,
  setuptools,
  trame_common,
  trame_client,
  trame_server
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
  ];

  propagatedBuildInputs = [
    pyyaml
    trame_common
    trame_server
    trame_client
  ];

  doCheck = false;
  pythonImportsCheck = [ "trame" ];

  meta = with lib; {
    description = "open-source platform for creating interactive and powerful visual analytics applications";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
}

