{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, hatchling
#, trame_common
}:
let
trame-common = buildPythonPackage rec {
  pname = "trame_common";
  version = "1.0.1";
  pyproject = true;
  
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-nUry2abQinQFl39FmTHKudS1OuEgqAJkVF9nnR+alLw=";
  };
  
  build-system = [
    setuptools
    hatchling
  ];
  
  doCheck = false;
  pythonImportsCheck = [ "trame_common" ];
  
  meta = with lib; {
    description = "server implementation of trame";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
};

in
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
    trame-common
  ];
  
  doCheck = false;
  pythonImportsCheck = [ "trame_client" ];
  
  meta = with lib; {
    description = " trame-client provides the infrastructure on the client-side (browser) to connect to a trame server, synchronize its state with the server, make method call, load dynamically components and feed a dynamic template provided by the server.";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
}
