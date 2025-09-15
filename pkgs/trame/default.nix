{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, pyyaml
, trame_server
, trame_client
, trame_common
, wslink
}:

buildPythonPackage rec {
  pname = "trame";
  version = "3.12.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-iLhhFiy4sCXoTpPxfc/UOoTQLSwWCMn21Y481kalDAU=";
  };

  build-system = [ setuptools ];

  dependencies = [
    pyyaml
    trame_server
    trame_client
    trame_common
    wslink
  ];

  doCheck = false;
  pythonImportsCheck = [ "trame" ];

  meta = with lib; {
    description = "Open-source platform for creating interactive and powerful visual analytics applications";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
}
