import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/data/models/error/app_error.model.dart';
import '../../../data/model/form.model.dart';
import '../../../domain/repository/dynamic_form.repository.dart';

part 'get_dynamic_form.event.dart';
part 'get_dynamic_form.state.dart';

class GetDynamicFormBloc extends Bloc<FormEvent, GetDynamicFormState> {
  final IDynamicFormRepository _dynamicFormRepository;

  GetDynamicFormBloc({required IDynamicFormRepository dynamicFormRepository})
    : _dynamicFormRepository = dynamicFormRepository,
      super(GetDynamicFormInitial()) {
    on<GetDynamicFormEvent>(_onGetDynamicFormEvent);
  }

  Future<void> _onGetDynamicFormEvent(
    GetDynamicFormEvent event,
    Emitter<GetDynamicFormState> emit,
  ) async {
    emit(GetDynamicFormLoading());

    final result = await _dynamicFormRepository.getForm();

    result.fold(
      (error) => emit(GetDynamicFormError(error: error)),
      (form) => emit(GetDynamicFormLoaded(form: form)),
    );
  }
}
