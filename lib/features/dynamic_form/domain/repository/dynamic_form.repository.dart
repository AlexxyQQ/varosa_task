import 'package:fpdart/fpdart.dart';

import '../../../../core/common/data/models/error/app_error.model.dart';
import '../../data/model/form.model.dart';

abstract class IDynamicFormRepository {
  Future<Either<AppErrorModel, FromModel>> getForm();
  Future<Either<AppErrorModel, bool>> submitForm(FromModel form);
}
