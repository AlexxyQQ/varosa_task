import '../../../core/di/main.di.dart';
import '../data/data_source/local/dynamic_form.local.data_source.dart';
import '../data/repository/dynamic_form.repository.impl.dart';
import '../domain/repository/dynamic_form.repository.dart';
import '../presentation/bloc/get/get_dynamic_form.bloc.dart';
import '../presentation/bloc/post/post_dynamic_form.bloc.dart';

class DynamicFormDi {
  static void register() {
    // Data Source
    sl.registerSingleton<DynamicFormLocalDataSource>(
      DynamicFormLocalDataSource(),
    );

    // Repository
    sl.registerSingleton<IDynamicFormRepository>(
      DynamicFormRepositoryImpl(dynamicFormLocalDataSource: sl()),
    );

    // Bloc
    sl.registerFactory<GetDynamicFormBloc>(
      () => GetDynamicFormBloc(dynamicFormRepository: sl()),
    );

    sl.registerFactory<PostDynamicFormBloc>(
      () => PostDynamicFormBloc(dynamicFormRepository: sl()),
    );
  }
}
