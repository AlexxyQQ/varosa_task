import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/enum/input_type.enum.dart';
import '../../../data/model/form_step.model.dart';

part 'form_state.event.dart';
part 'form_state.state.dart';

class FormStateBloc extends Bloc<FormStateEvent, FormStateState> {
  FormStateBloc() : super(FormStateInitial()) {
    on<UpdateFormValueEvent>(_onUpdateFormValue);
    on<ValidateFormEvent>(_onValidateForm);
    on<ResetFormEvent>(_onResetForm);
    on<InitializeFormEvent>(_onInitializeForm);
  }

  void _onUpdateFormValue(
    UpdateFormValueEvent event,
    Emitter<FormStateState> emit,
  ) {
    if (state is FormStateLoaded) {
      final currentState = state as FormStateLoaded;
      final updatedValues = Map<String, dynamic>.from(currentState.formValues);
      updatedValues[event.key] = event.value;

      emit(
        currentState.copyWith(
          formValues: updatedValues,
          errors: Map<String, String>.from(currentState.errors)
            ..remove(event.key),
        ),
      );
    }
  }

  void _onValidateForm(ValidateFormEvent event, Emitter<FormStateState> emit) {
    if (state is FormStateLoaded) {
      final currentState = state as FormStateLoaded;
      final errors = <String, String>{};

      // Validate each input based on requirements and validation rules
      for (final step in event.formSteps) {
        for (final input in step.inputs ?? []) {
          final key = input.key;
          final value = currentState.formValues[key];
          final isRequired = input.required ?? false;
          log('isRequired: $isRequired');

          if (key != null) {
            // Check required fields
            if (isRequired &&
                (value == null || value.toString().trim().isEmpty)) {
              errors[key] = '${input.label} is required';
              continue;
            }

            // Type-specific validation
            if (value != null && value.toString().isNotEmpty) {
              switch (input.type) {
                case InputType.email:
                  if (!_isValidEmail(value.toString())) {
                    errors[key] = 'Please enter a valid email address';
                  }
                case InputType.phone:
                  if (!_isValidPhone(value.toString())) {
                    errors[key] = 'Please enter a valid phone number';
                  }
                case InputType.number:
                  if (!_isValidNumber(value.toString())) {
                    errors[key] = 'Please enter a valid number';
                  }
                default:
                  break;
              }
            }
          }
        }
      }

      emit(currentState.copyWith(errors: errors, isValid: errors.isEmpty));
    }
  }

  void _onResetForm(ResetFormEvent event, Emitter<FormStateState> emit) {
    emit(const FormStateLoaded(formValues: {}, errors: {}, isValid: false));
  }

  void _onInitializeForm(
    InitializeFormEvent event,
    Emitter<FormStateState> emit,
  ) {
    final initialValues = <String, dynamic>{};

    // Set default values from form configuration
    for (final step in event.formSteps) {
      for (final input in step.inputs ?? []) {
        if (input.key != null) {
          final defaultValue = input.defaultValue ?? input.defaultValueAlt;
          if (defaultValue != null) {
            initialValues[input.key!] = defaultValue;
          }
        }
      }
    }

    emit(
      FormStateLoaded(
        formValues: initialValues,
        errors: const {},
        isValid: false,
      ),
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^\+?[\d\s\-\(\)]{10,}$').hasMatch(phone);
  }

  bool _isValidNumber(String number) {
    return RegExp(r'^\d+$').hasMatch(number);
  }
}
