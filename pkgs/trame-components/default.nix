{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, trame_client
}:

buildPythonPackage rec {
  pname = "trame_components";
  version = "2.5.0";
  pyproject = true;
  
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-gITuQ4LbH20X0PdYkKcPZ6MIvrtX1UhuE0nHRogS7Pg=";
  };
  
  build-system = [
    setuptools
  ];
  
  buildInputs = [
    trame_client
  ];
  
  doCheck = false;
  pythonImportsCheck = [ "trame_components" ];
  
  meta = with lib; {
    description = "Trame-components extend trame widgets with helper components that are core to trame widgets.";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
}
