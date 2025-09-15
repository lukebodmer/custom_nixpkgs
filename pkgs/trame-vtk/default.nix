{ lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  trame_client,
}:

buildPythonPackage rec {
  pname = "trame_vtk";
  version = "2.9.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-JCPwy3wBm9kZ0xPpBKuN4v4dv8Xj/3eWH8E+qdG4lZQ=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    trame_client
  ];

  doCheck = false;
  pythonImportsCheck = [ "trame_vtk" ];

  meta = with lib; {
    description = "VTK integration in trame allows you to create rich visualization and data processing applications by leveraging the Python wrapping of the VTK library.";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
}

