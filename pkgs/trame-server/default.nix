{ lib,
  buildPythonPackage,
  more-itertools,
  fetchPypi,
  setuptools,
  wslink
}:

buildPythonPackage rec {
  pname = "trame_server";
  version = "3.6.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-bHXawT6ENpkPmv/yFSjmQoD1OVr6LirpYo5ko0BM3l4=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    more-itertools
    wslink
  ];

  doCheck = false;
  pythonImportsCheck = [ "trame_server" ];

  meta = with lib; {
    description = "server implementation of trame";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
}

