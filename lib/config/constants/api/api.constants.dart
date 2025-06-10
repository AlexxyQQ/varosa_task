import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String baseAPIURL = dotenv.env['BASE_API_URL'] ?? '';
  static const Duration receiveTimeout = Duration(seconds: 60);
  static const Duration connectTimeout = Duration(seconds: 60);
}
