{ lib
, buildPythonPackage
, fetchPypi
, setuptools
#, trame-client
}:

buildPythonPackage rec {
  pname = "mpld3";
  version = "0.5.11";
  pyproject = true;
  
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-TPC+sJL8KxGYhIA0agyuPOX+AmdCnHh2cnqDib3tXNY=";
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
