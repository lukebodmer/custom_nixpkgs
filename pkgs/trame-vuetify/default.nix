{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, trame-client
}:

buildPythonPackage rec {
  pname = "trame_vuetify";
  version = "3.0.3";
  pyproject = true;
  
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-gITuQ4LbH20X0PdYkKcPZ6MIvrtX1UhuE0nHRogS7Pg=";
  };
  
  build-system = [
    setuptools
  ];
  
  buildInputs = [
    trame-client
  ];
 
  doCheck = false;
  pythonImportsCheck = [ "trame_vuetify" ];

  # See pkgs/trame/default.nix: strip the bytecode of the shared namespace stub
  # trame/__init__.py so it merges in buildEnv instead of colliding.
  postFixup = ''
    find $out -type d -name __pycache__ -prune -exec rm -rf {} +
  '';
  
  meta = with lib; {
    description = "VTK integration in trame allows you to create rich visualization and data processing applications by leveraging the Python wrapping of the VTK library.";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
}
