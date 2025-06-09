part of 'get_dynamic_form.bloc.dart';

abstract class FormEvent extends Equatable {
  const FormEvent();
}

class GetDynamicFormEvent extends FormEvent {
  const GetDynamicFormEvent();

  @override
  List<Object> get props => [];
}
