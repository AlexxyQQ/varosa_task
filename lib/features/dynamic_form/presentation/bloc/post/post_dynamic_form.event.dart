part of 'post_dynamic_form.bloc.dart';

abstract class PostDynamicFormEvent extends Equatable {
  const PostDynamicFormEvent();
}

class SubmitFormEvent extends PostDynamicFormEvent {
  final FromModel form;
  const SubmitFormEvent({required this.form});

  @override
  List<Object> get props => [form];
}
