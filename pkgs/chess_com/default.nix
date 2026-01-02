{ lib,
  fetchPypi,
  requests,
  aiohttp,
  buildPythonPackage,
  setuptools,
  wheel
}:

buildPythonPackage rec {
  pname = "chess_com";
  version = "3.13.0";
  pyproject = true;

  # Fetch the source from PyPI
  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-4G6213QAEVdOSvnqDoCKltS92t6F3udv9ZW/Jjabwf0=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  propagatedBuildInputs = [
    requests
    aiohttp
  ];

  # Optional: disable tests (depends on upstream tests)
  doCheck = false;

  meta = with lib; {
    description = "Python client for the Chess.com Public API";
    homepage = "https://github.com/…";  # upstream repo (if known)
    license = licenses.mit;
    maintainers = with maintainers; [ /* your nixpkgs handle */ ];
  };
}
