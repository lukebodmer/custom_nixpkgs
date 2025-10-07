{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, jinja2
, matplotlib
}:

buildPythonPackage rec {
  pname = "mpld3";
  version = "0.5.11";
  pyproject = true;
  
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-v/4sk/i0BvjU3AWVZd/stHeeih/FC/u05/XUdqJ06rc=";
  };
  
  build-system = [
    setuptools
  ];
  
  buildInputs = [
    jinja2
    matplotlib
  ];
 
  doCheck = false;
  
  meta = with lib; {
    description = "trame-matplotlib extend trame widgets with a component that is capable of rendering Matplotlib plots.";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
}
