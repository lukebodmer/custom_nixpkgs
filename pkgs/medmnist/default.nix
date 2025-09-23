{ lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  numpy,
  pandas,
  scikit-learn,
  scikit-image,
  tqdm,
  pillow,
  fire,
  torch-bin,
  torchvision-bin,
}:

buildPythonPackage rec {
  pname = "medmnist";
  version = "3.0.2";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-oMsrNxVWEElEW4rW6DdaPfey9KY6t1wuOydxnYOdOsQ=";
  };

  build-system = [
    setuptools
  ];

  propagatedBuildInputs = [
    numpy
    pandas
    scikit-learn
    scikit-image
    tqdm
    pillow
    fire
    torch-bin
    torchvision-bin
  ];

  doCheck = false;
  pythonImportsCheck = [ "medmnist" ];

  meta = with lib; {
    description = "a large-scale MNIST-like collection of standardized biomedical images";
    homepage = "https://medmnist.com/";
    license = licenses.asl20;
  };
}

