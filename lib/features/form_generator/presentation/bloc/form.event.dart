// part of 'form.bloc.dart';

// abstract class FormEvent extends Equatable {
//   const FormEvent();

//   @override
//   List<Object?> get props => [];
// }

// class GetFormEvent extends FormEvent {
//   const GetFormEvent();
// }

// class SubmitFormEvent extends FormEvent {
//   const SubmitFormEvent();
// }

// class UpdateFieldValueEvent extends FormEvent {
//   final String fieldKey;
//   final dynamic value;

//   const UpdateFieldValueEvent({required this.fieldKey, required this.value});

//   @override
//   List<Object?> get props => [fieldKey, value];
// }

// class NextStepEvent extends FormEvent {
//   const NextStepEvent();
// }

// class PreviousStepEvent extends FormEvent {
//   const PreviousStepEvent();
// }

// class GoToStepEvent extends FormEvent {
//   final int stepIndex;

//   const GoToStepEvent(this.stepIndex);

//   @override
//   List<Object?> get props => [stepIndex];
// }

// class ValidateCurrentStepEvent extends FormEvent {
//   const ValidateCurrentStepEvent();
// }

// class ResetFormEvent extends FormEvent {
//   const ResetFormEvent();
// }

// class LoadFormEvent extends FormEvent {
//   final FormData formData;

//   const LoadFormEvent(this.formData);

//   @override
//   List<Object?> get props => [formData];
// }
