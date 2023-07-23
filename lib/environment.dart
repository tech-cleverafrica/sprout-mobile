/// This takes care of the environment variables based on where the app is pointing to

class Environment {
  static const environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: "development",
  );

  static const apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://be.clevermoni.com/',
    // defaultValue: 'https://dev.cleverafrica.com/',
  );

  static const flutterWaveKey = String.fromEnvironment(
    'FLUTTERWAVE_KEY',
    defaultValue: 'FLWPUBK-e07b6d34819bcbc5923bbd6b5dbb6a11-X',
    // defaultValue: 'FLWPUBK_TEST-c9c17e8e7f23ee3e840970bc2143326d-X',
  );

  static const isTestMode = String.fromEnvironment(
    'IS_TEST_MODE',
    defaultValue: 'PROD',
    // defaultValue: 'TEST',
  );
}
