{ lib
, buildPythonPackage
, fetchPypi
, google-api-core
, mock
, proto-plus
, protobuf
, pytest-asyncio
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "google-cloud-texttospeech";
  version = "2.16.0";
  format = "setuptools";

  disabled = pythonOlder "3.8";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-flG/fsyx8DH/w49EF5ddckPZoVDvkPsz/SFI16CVWR8=";
  };

  propagatedBuildInputs = [
    google-api-core
    proto-plus
    protobuf
  ] ++ google-api-core.optional-dependencies.grpc;

  nativeCheckInputs = [
    mock
    pytest-asyncio
    pytestCheckHook
  ];

  disabledTests = [
    # Disable tests that require credentials
    "test_list_voices"
    "test_synthesize_speech"
  ];

  pythonImportsCheck = [
    "google.cloud.texttospeech"
    "google.cloud.texttospeech_v1"
    "google.cloud.texttospeech_v1beta1"
  ];

  meta = with lib; {
    description = "Google Cloud Text-to-Speech API client library";
    homepage = "https://github.com/googleapis/google-cloud-python/tree/main/packages/google-cloud-texttospeech";
    changelog = "https://github.com/googleapis/google-cloud-python/blob/google-cloud-texttospeech-v${version}/packages/google-cloud-texttospeech/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
  };
}
