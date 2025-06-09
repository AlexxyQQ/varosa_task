part of 'form_state.bloc.dart';

abstract class FormStateEvent extends Equatable {
  const FormStateEvent();

  @override
  List<Object?> get props => [];
}

class UpdateFormValueEvent extends FormStateEvent {
  final String key;
  final dynamic value;

  const UpdateFormValueEvent({required this.key, required this.value});

  @override
  List<Object?> get props => [key, value];
}

class ValidateFormEvent extends FormStateEvent {
  final List<FormStepModel> formSteps;

  const ValidateFormEvent({required this.formSteps});

  @override
  List<Object?> get props => [formSteps];
}

class ResetFormEvent extends FormStateEvent {
  const ResetFormEvent();
}

class InitializeFormEvent extends FormStateEvent {
  final List<FormStepModel> formSteps;

  const InitializeFormEvent({required this.formSteps});

  @override
  List<Object?> get props => [formSteps];
}
