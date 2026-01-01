{ lib
, fetchPypi
, python3Packages
}:

python3Packages.buildPythonPackage rec {
  pname = "python-chess-com";
  version = "3.13.0";

  # Fetch the source from PyPI
  src = fetchPypi {
    inherit pname version;
    # SHA256 from the PyPI source tarball
    sha256 = "e06eb6d7740011574e4af9ea0e808a96d4bddade85dee76ff595bf26369bc1fd";
  };

  # Build inputs/dependencies
  # You must include any runtime deps not already in nixpkgs
  propagatedBuildInputs = with python3Packages; [
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
