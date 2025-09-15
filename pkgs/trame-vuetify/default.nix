{ lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  trame_client,
  trame_vtk,
  hatchling
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
    #hatchling
    trame_client
    trame_vtk
  ];

  dependencies = [
    #trame_client
  ];

  doCheck = false;
  pythonImportsCheck = [ "trame_vtk" ];

  meta = with lib; {
    description = "VTK integration in trame allows you to create rich visualization and data processing applications by leveraging the Python wrapping of the VTK library.";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
}

