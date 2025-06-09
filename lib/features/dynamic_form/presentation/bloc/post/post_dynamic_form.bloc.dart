import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/data/models/error/app_error.model.dart';
import '../../../data/model/form.model.dart';
import '../../../domain/repository/dynamic_form.repository.dart';

part 'post_dynamic_form.event.dart';
part 'post_dynamic_form.state.dart';

class PostDynamicFormBloc
    extends Bloc<PostDynamicFormEvent, PostDynamicFormState> {
  final IDynamicFormRepository _dynamicFormRepository;

  PostDynamicFormBloc({required IDynamicFormRepository dynamicFormRepository})
    : _dynamicFormRepository = dynamicFormRepository,
      super(PostDynamicFormInitial()) {
    on<SubmitFormEvent>(_onSubmitFormEvent);
  }

  Future<void> _onSubmitFormEvent(
    SubmitFormEvent event,
    Emitter<PostDynamicFormState> emit,
  ) async {
    emit(PostDynamicFormLoading());

    final result = await _dynamicFormRepository.submitForm(event.form);

    result.fold(
      (error) => emit(PostDynamicFormError(error: error)),
      (form) => emit(const PostDynamicFormSuccess()),
    );
  }
}
