class Environment {
  static const environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: "development",
  );

  static const apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://dev.cleverafrica.com/',
  );
}
