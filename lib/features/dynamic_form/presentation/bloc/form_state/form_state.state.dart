part of 'form_state.bloc.dart';

abstract class FormStateState extends Equatable {
  const FormStateState();

  @override
  List<Object?> get props => [];
}

class FormStateInitial extends FormStateState {}

class FormStateLoaded extends FormStateState {
  final Map<String, dynamic> formValues;
  final Map<String, String> errors;
  final bool isValid;

  const FormStateLoaded({
    required this.formValues,
    required this.errors,
    required this.isValid,
  });

  @override
  List<Object?> get props => [formValues, errors, isValid];

  FormStateLoaded copyWith({
    Map<String, dynamic>? formValues,
    Map<String, String>? errors,
    bool? isValid,
  }) {
    return FormStateLoaded(
      formValues: formValues ?? this.formValues,
      errors: errors ?? this.errors,
      isValid: isValid ?? this.isValid,
    );
  }
}
