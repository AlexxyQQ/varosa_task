import 'package:fpdart/fpdart.dart';

import '../../../../core/common/data/models/error/app_error.model.dart';
import '../../domain/repository/dynamic_form.repository.dart';
import '../data_source/local/dynamic_form.local.data_source.dart';
import '../model/form.model.dart';

class DynamicFormRepositoryImpl implements IDynamicFormRepository {
  final DynamicFormLocalDataSource _dynamicFormLocalDataSource;

  DynamicFormRepositoryImpl({
    required DynamicFormLocalDataSource dynamicFormLocalDataSource,
  }) : _dynamicFormLocalDataSource = dynamicFormLocalDataSource;

  @override
  Future<Either<AppErrorModel, FromModel>> getForm() async {
    return _dynamicFormLocalDataSource.getForm();
  }

  @override
  Future<Either<AppErrorModel, bool>> submitForm(FromModel form) async {
    return _dynamicFormLocalDataSource.submitForm(form);
  }
}
