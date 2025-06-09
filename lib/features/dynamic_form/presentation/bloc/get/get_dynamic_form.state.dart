part of 'get_dynamic_form.bloc.dart';

abstract class GetDynamicFormState extends Equatable {
  const GetDynamicFormState();

  @override
  List<Object?> get props => [];
}

class GetDynamicFormInitial extends GetDynamicFormState {}

class GetDynamicFormLoading extends GetDynamicFormState {}

class GetDynamicFormLoaded extends GetDynamicFormState {
  final FromModel? form;

  const GetDynamicFormLoaded({this.form});

  @override
  List<Object?> get props => [form];
}

class GetDynamicFormError extends GetDynamicFormState {
  final AppErrorModel error;

  const GetDynamicFormError({required this.error});

  @override
  List<Object?> get props => [error];
}
