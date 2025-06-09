import 'package:uuid/uuid.dart';

class ModelGeneratorHelper {
  static final ModelGeneratorHelper _instance = ModelGeneratorHelper._();
  ModelGeneratorHelper._();
  static ModelGeneratorHelper get instance => _instance;

  static String generateUuidFromJson(String? id) {
    if (id != null) {
      return id;
    }
    const uuid = Uuid();
    return uuid.v4();
  }

  static DateTime? generateCreatedAtFromJson(String? createdAt) {
    if (createdAt != null) {
      return DateTime.parse(createdAt);
    }
    return DateTime.now();
  }

  static DateTime? generateUpdatedAtFromJson(String? updatedAt) {
    if (updatedAt != null) {
      return DateTime.parse(updatedAt);
    }
    return DateTime.now();
  }
}
