{ lib
, buildPythonPackage
, fetchPypi
, setuptools
#, trame-client
}:

buildPythonPackage rec {
  pname = "trame-matplotlib";
  version = "2.0.3";
  pyproject = true;
  
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-gITuQ4LbH20X0PdYkKcPZ6MIvrtX1UhuE0nHRogS7Pg=";
  };
  
  build-system = [
    setuptools
  ];
  
  buildInputs = [
#    trame-client
  ];
 
  doCheck = false;
  
  meta = with lib; {
    description = "trame-matplotlib extend trame widgets with a component that is capable of rendering Matplotlib plots.";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
}
