{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, trame-client
}:

buildPythonPackage rec {
  pname = "trame-components";
  version = "2.5.0";
  pyproject = true;
  
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-33odOHuYxd1xaZc3gE9SiJV8o3DrGmC75A6Jofn2KxI=";
  };
  
  build-system = [
    setuptools
  ];
  
  buildInputs = [
    trame-client
  ];
  
  doCheck = false;
#  pythonImportsCheck = [ "trame_components" ];
  
  meta = with lib; {
    description = "Trame-components extend trame widgets with helper components that are core to trame widgets.";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
}
