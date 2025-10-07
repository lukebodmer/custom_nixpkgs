{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, trame-client
, mpld3
}:

buildPythonPackage rec {
  pname = "trame-matplotlib";
  version = "2.0.3";
  pyproject = true;
  
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-TPC+sJL8KxGYhIA0agyuPOX+AmdCnHh2cnqDib3tXNY=";
  };
  
  build-system = [
    setuptools
  ];
  
  buildInputs = [
    trame-client
  ];

   propagatedBuildInputs = [
    mpld3
  ];
 
  doCheck = false;
  
  meta = with lib; {
    description = "trame-matplotlib extend trame widgets with a component that is capable of rendering Matplotlib plots.";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
}
