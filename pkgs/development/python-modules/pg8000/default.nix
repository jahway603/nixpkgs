{ lib
, buildPythonPackage
, fetchPypi
, importlib-metadata
, passlib
, python-dateutil
, pythonOlder
, scramp
, setuptools
, versioningit
}:

buildPythonPackage rec {
  pname = "pg8000";
  version = "1.30.5";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-By960AzXI2lcsun8AsHfuEx4FFXpe43m9MQoHuoIB4w=";
  };

  nativeBuildInputs = [
    setuptools
    versioningit
  ];

  propagatedBuildInputs = [
    passlib
    python-dateutil
    scramp
  ] ++ lib.optionals (pythonOlder "3.8") [
    importlib-metadata
  ];

  # Tests require a running PostgreSQL instance
  doCheck = false;

  pythonImportsCheck = [
    "pg8000"
  ];

  meta = with lib; {
    description = "Python driver for PostgreSQL";
    homepage = "https://github.com/tlocke/pg8000";
    changelog = "https://github.com/tlocke/pg8000#release-notes";
    license = with licenses; [ bsd3 ];
    maintainers = with maintainers; [ domenkozar ];
    platforms = platforms.unix;
  };
}
