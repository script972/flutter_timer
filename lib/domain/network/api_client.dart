enum Environment {SANDBOX, PROD}

class ApiClient {

  static final String SANDBOX = "https://pastebin.com";
  static final String PROD = "";
  static final String BASE_ENDPOINT = "";

  static final String BASE_URL = _getBaseUrl(Environment.SANDBOX);

  static String _getBaseUrl(Environment buildEnvironment) {
    switch (buildEnvironment) {
      case Environment.SANDBOX:
        return SANDBOX;
      case Environment.PROD:
        return PROD;
      default:
        return PROD;
    }
  }

}