{ lib
, buildPythonPackage
, fetchPypi
, setuptools
#, trame_client
, trame_server
, trame_common
, trame_vuetify
, trame_vtk
, wslink
, pyyaml
}:
let
  trame_client = buildPythonPackage rec {
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
    
    dependencies = [
      trame_common
    ];
    
    doCheck = false;
    pythonImportsCheck = [ "trame_client" ];
    
    meta = with lib; {
      description = " trame-client provides the infrastructure on the client-side (browser) to connect to a trame server, synchronize its state with the server, make method call, load dynamically components and feed a dynamic template provided by the server.";
      homepage = "https://kitware.github.io/trame/";
      license = licenses.asl20;
    };
  };
in
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
