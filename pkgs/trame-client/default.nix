{ lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  trame_common,
}:

buildPythonPackage rec {
  pname = "trame_client";
  version = "3.10.2";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-ZsfQNOEmMWig0NpzY2oV0Nt27UFjZywTTcYJvuFF/JA=";
  };

  build-system = [
    setuptools
  ];

  propagatedBuildInputs = [
    trame_common
  ];

  doCheck = false;
  pythonImportsCheck = [ "trame_client" ];

  meta = with lib; {
    description = " trame-client provides the infrastructure on the client-side (browser) to connect to a trame server, synchronize its state with the server, make method call, load dynamically components and feed a dynamic template provided by the server.";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
}

