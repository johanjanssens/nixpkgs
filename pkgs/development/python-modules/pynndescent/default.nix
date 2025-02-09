{ lib
, buildPythonPackage
, fetchPypi
, joblib
, llvmlite
, numba
, scikit-learn
, scipy
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "pynndescent";
  version = "0.5.6";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-YfsxiFuqxGnWeTPix8k1tu3rsG7kmOLw+d/JfFnTclw=";
  };

  propagatedBuildInputs = [
    joblib
    llvmlite
    numba
    scikit-learn
    scipy
  ];

  checkInputs = [
    pytestCheckHook
  ];

  disabledTests = [
    # numpy.core._exceptions._UFuncNoLoopError
    "test_sparse_nn_descent_query_accuracy_angular"
    "test_nn_descent_query_accuracy_angular"
    "test_alternative_distances"
    # scipy: ValueError: Unknown Distance Metric: wminkowski
    # https://github.com/scikit-learn/scikit-learn/pull/21741
    "test_weighted_minkowski"
  ];

  pythonImportsCheck = [
    "pynndescent"
  ];

  meta = with lib; {
    description = "Nearest Neighbor Descent";
    homepage = "https://github.com/lmcinnes/pynndescent";
    license = licenses.bsd2;
    maintainers = with maintainers; [ mic92 ];
  };
}
