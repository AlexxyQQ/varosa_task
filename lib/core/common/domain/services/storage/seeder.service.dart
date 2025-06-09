import '../../../../../features/todo/data/data_sources/local/todo.local.data_source.dart';
import '../../../../di/main.di.dart';

class SeederService {
  static final SeederService _instance = SeederService._();
  SeederService._();
  static SeederService get instance => _instance;

  static Future<void> seedData() async {
    await sl<ItemLocalDataSource>().seed();
  }
}
