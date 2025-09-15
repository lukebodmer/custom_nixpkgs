{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, trame_client
, trame_server
, trame_common
, trame_vuetify
, trame_vtk
, wslink
, pyyaml
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

  # replicate what pip would pull in
  propagatedBuildInputs = [
    pyyaml
    trame_client
    trame_server
    trame_common
    trame_vuetify
    trame_vtk
    wslink
  ];

  doCheck = false;
  pythonImportsCheck = [ "trame" ];

  meta = with lib; {
    description = "Unified front-end for interactive applications (umbrella package)";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
}
