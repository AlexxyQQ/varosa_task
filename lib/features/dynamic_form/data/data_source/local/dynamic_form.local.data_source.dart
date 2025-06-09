import 'package:fpdart/fpdart.dart';

import '../../../../../config/constants/data/form.data.dart';
import '../../../../../core/common/data/models/error/app_error.model.dart';
import '../../model/form.model.dart';

class DynamicFormLocalDataSource {
  Future<Either<AppErrorModel, FromModel>> getForm() async {
    const formData = FormData.data;
    final form = FromModel.fromJson(formData['form']);

    return right(form);
  }

  Future<Either<AppErrorModel, bool>> submitForm(FromModel form) async {
    return right(true);
  }
}
