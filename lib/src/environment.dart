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
}
