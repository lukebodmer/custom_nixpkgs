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
    hash = "sha256-A41aT+yxjL7as3VPnbgmXDx5SschM+R9SzMD1Qxkx1g=";
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

