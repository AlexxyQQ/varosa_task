import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../enums/flavors.dart';
import '../gen/assets.gen.dart';

/// Base class for application environment configurations.
///
/// This class serves as a template for handling environment-specific
/// configurations in the application, such as loading different .env files
/// and retrieving environment variables. It is sealed to restrict subclassing
/// to predefined types, ensuring consistent implementation.
sealed class AppEnv {
  const AppEnv();

  /// Method to get environment variables based on the provided key.
  ///
  /// The implementation of this method should be provided by subclasses
  /// to fetch environment variables specific to the application's
  /// configuration.
  String getEnv(String key);
}

/// Class representing the specific flavor configuration of the application.
///
/// This class manages the application's environment based on the flavor
/// (development, staging, or production) and provides functionality to
/// load environment variables specific to the current flavor.
class AppFlavor extends AppEnv {
  /// The flavor of the current environment (development, staging, production).
  final Flavor flavor;

  /// Private constructor for creating flavor configurations.
  ///
  /// This constructor is used internally by the factory methods to
  /// create an instance of AppFlavor with the specified flavor.
  const AppFlavor._({required this.flavor});

  /// Factory method to create a development environment configuration.
  ///
  /// Returns an instance of AppFlavor configured for development.
  factory AppFlavor.development() =>
      const AppFlavor._(flavor: Flavor.development);

  /// Factory method to create a staging environment configuration.
  ///
  /// Returns an instance of AppFlavor configured for staging.
  factory AppFlavor.staging() => const AppFlavor._(flavor: Flavor.staging);

  /// Factory method to create a production environment configuration.
  ///
  /// Returns an instance of AppFlavor configured for production.
  factory AppFlavor.production() =>
      const AppFlavor._(flavor: Flavor.production);

  /// Loads the corresponding .env file based on the current flavor.
  ///
  /// This method asynchronously loads environment variables from
  /// .env files specific to the current environment. For development and
  /// staging, it loads the local environment file, while for production,
  /// it loads the production environment file.
  Future<void> loadEnvironment() async {
    switch (flavor) {
      case Flavor.development:
        await dotenv.load(
          fileName: Assets.env.dev,
        ); // Load local environment for development
      case Flavor.staging:
        await dotenv.load(
          fileName: Assets.env.stage,
        ); // Load local environment for staging
      case Flavor.production:
        await dotenv.load(
          fileName: Assets.env.prod,
        ); // Load production environment
    }
  }

  /// Returns the environment variable based on the provided key.
  ///
  /// This method fetches the environment variable corresponding to the
  /// given key from the loaded .env file. If the key is not found,
  /// it returns 'Key not found'.
  ///
  /// - Parameter key: The key of the environment variable to retrieve.
  /// - Returns: The value of the environment variable, or 'Key not found' if the key does not exist.
  @override
  String getEnv(String key) {
    return dotenv.env[key] ??
        'Key not found'; // Retrieve environment variable or default message
  }
}
