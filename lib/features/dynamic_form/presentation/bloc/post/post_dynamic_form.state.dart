part of 'post_dynamic_form.bloc.dart';

abstract class PostDynamicFormState extends Equatable {
  const PostDynamicFormState();

  @override
  List<Object?> get props => [];
}

class PostDynamicFormInitial extends PostDynamicFormState {}

class PostDynamicFormLoading extends PostDynamicFormState {}

class PostDynamicFormSuccess extends PostDynamicFormState {
  const PostDynamicFormSuccess();

  @override
  List<Object?> get props => [];
}

class PostDynamicFormError extends PostDynamicFormState {
  final AppErrorModel error;

  const PostDynamicFormError({required this.error});

  @override
  List<Object?> get props => [error];
}
