{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, aiohttp
, msgpack
, more-itertools
, pyyaml
, trame-client
}:
let

  wslink = buildPythonPackage rec {
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
    
    dependencies = [
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
  };

  trame-server = buildPythonPackage rec {
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
    trame-client
    trame-server
    #trame_common
    wslink
  ];

  doCheck = false;
  pythonImportsCheck = [ "trame" ];

  # Every trame-* distribution ships the same namespace stub trame/__init__.py
  # (pkgutil.extend_path).  The .py files are byte-identical and buildEnv
  # merges them, but each derivation byte-compiles the stub and the resulting
  # __pycache__/__init__*.pyc embeds the source mtime, so two packages collide
  # in buildEnv.  Drop the bytecode; the identical .py merge cleanly and Python
  # runs fine without the cache in a read-only store.
  postFixup = ''
    find $out -type d -name __pycache__ -prune -exec rm -rf {} +
  '';

  meta = with lib; {
    description = "Unified front-end for interactive applications (umbrella package)";
    homepage = "https://kitware.github.io/trame/";
    license = licenses.asl20;
  };
}
