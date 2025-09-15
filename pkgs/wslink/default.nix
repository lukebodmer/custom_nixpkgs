{ lib,
  buildPythonPackage,
  aiohttp,
  msgpack,
  fetchPypi,
  setuptools,
}:

buildPythonPackage rec {
  pname = "wslink";
  version = "2.4.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-iLhhFiy4sCXoTpPxfc/UOoTQLSwWCMn21Y481kalDAU=";
  };

  build-system = [
    setuptools
  ];

  propagatedBuildInputs = [
    aiohttp
    msgpack
  ];

  doCheck = false;
  pythonImportsCheck = [ "wslink" ];

  meta = with lib; {
    description = "easy, bi-directional communication between a python server and a javascript client over a websocket.";
    homepage = "https://github.com/kitware/wslink";
    license = licenses.bsd3;
  };
}

