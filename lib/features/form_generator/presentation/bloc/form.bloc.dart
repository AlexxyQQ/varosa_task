// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// import '../../../../core/common/data/models/error/app_error.model.dart';
// import '../../data/model/form.model.dart';
// import '../../data/model/form_input.model.dart';
// import '../../data/model/form_step.model.dart';

// part 'form.event.dart';
// part 'form.state.dart';
// part 'form.bloc.freezed.dart';

// class FormBloc extends Bloc<FormEvent, DynamicFormState> {
//   FormBloc() : super(DynamicFormState.initial()) {
//     on<LoadFormEvent>(_onLoadFormEvent);
//     on<UpdateFieldValueEvent>(_onUpdateFieldValueEvent);
//     on<NextStepEvent>(_onNextStepEvent);
//     on<PreviousStepEvent>(_onPreviousStepEvent);
//     on<GoToStepEvent>(_onGoToStepEvent);
//     on<ValidateCurrentStepEvent>(_onValidateCurrentStepEvent);
//     on<SubmitFormEvent>(_onSubmitFormEvent);
//     on<GetFormEvent>(_onGetFormEvent);
//     on<ResetFormEvent>(_onResetFormEvent);
//   }

//   Future<void> _onLoadFormEvent(
//     LoadFormEvent event,
//     Emitter<DynamicFormState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true, error: null));

//     try {
//       // Initialize field values with defaults
//       final Map<String, dynamic> initialValues = {};
//       for (final step in event.formData.steps) {
//         for (final input in step.inputs) {
//           if (input.effectiveDefault != null) {
//             initialValues[input.key] = input.effectiveDefault;
//           }
//         }
//       }

//       emit(
//         state.copyWith(
//           isLoading: false,
//           form: event.formData,
//           fieldValues: initialValues,
//           currentStepIndex: 0,
//           fieldErrors: {},
//           isCurrentStepValid: false,
//           isFormValid: false,
//         ),
//       );

//       // Validate the initial step
//       add(const ValidateCurrentStepEvent());
//     } catch (e) {
//       emit(
//         state.copyWith(
//           isLoading: false,
//           error: AppErrorModel(message: 'Failed to load form: ${e.toString()}'),
//         ),
//       );
//     }
//   }

//   Future<void> _onUpdateFieldValueEvent(
//     UpdateFieldValueEvent event,
//     Emitter<DynamicFormState> emit,
//   ) async {
//     final updatedValues = Map<String, dynamic>.from(state.fieldValues);
//     updatedValues[event.fieldKey] = event.value;

//     // Clear any existing error for this field
//     final updatedErrors = Map<String, String>.from(state.fieldErrors);
//     updatedErrors.remove(event.fieldKey);

//     emit(
//       state.copyWith(fieldValues: updatedValues, fieldErrors: updatedErrors),
//     );

//     // Validate the current step after value update
//     add(const ValidateCurrentStepEvent());
//   }

//   Future<void> _onNextStepEvent(
//     NextStepEvent event,
//     Emitter<DynamicFormState> emit,
//   ) async {
//     if (state.form == null || state.isLastStep) return;

//     // Validate current step before proceeding
//     final isValid = await _validateCurrentStep();
//     if (!isValid) {
//       add(const ValidateCurrentStepEvent());
//       return;
//     }

//     final nextStepIndex = state.currentStepIndex + 1;
//     emit(
//       state.copyWith(
//         currentStepIndex: nextStepIndex,
//         isCurrentStepValid: false,
//       ),
//     );

//     // Validate the new current step
//     add(const ValidateCurrentStepEvent());
//   }

//   Future<void> _onPreviousStepEvent(
//     PreviousStepEvent event,
//     Emitter<DynamicFormState> emit,
//   ) async {
//     if (state.isFirstStep) return;

//     final previousStepIndex = state.currentStepIndex - 1;
//     emit(state.copyWith(currentStepIndex: previousStepIndex));

//     // Validate the new current step
//     add(const ValidateCurrentStepEvent());
//   }

//   Future<void> _onGoToStepEvent(
//     GoToStepEvent event,
//     Emitter<DynamicFormState> emit,
//   ) async {
//     if (state.form == null ||
//         event.stepIndex < 0 ||
//         event.stepIndex >= state.form!.steps.length)
//       return;

//     emit(state.copyWith(currentStepIndex: event.stepIndex));

//     // Validate the new current step
//     add(const ValidateCurrentStepEvent());
//   }

//   Future<void> _onValidateCurrentStepEvent(
//     ValidateCurrentStepEvent event,
//     Emitter<DynamicFormState> emit,
//   ) async {
//     final isValid = await _validateCurrentStep();
//     final isFormValid = await _validateAllSteps();

//     emit(state.copyWith(isCurrentStepValid: isValid, isFormValid: isFormValid));
//   }

//   Future<void> _onSubmitFormEvent(
//     SubmitFormEvent event,
//     Emitter<DynamicFormState> emit,
//   ) async {
//     if (state.form == null) return;

//     emit(state.copyWith(isSubmitting: true, error: null));

//     try {
//       // Validate all steps before submission
//       final isFormValid = await _validateAllSteps();
//       if (!isFormValid) {
//         emit(
//           state.copyWith(
//             isSubmitting: false,
//             error: AppErrorModel(
//               message: 'Please fix all validation errors before submitting',
//             ),
//           ),
//         );
//         return;
//       }

//       // Simulate form submission (replace with actual API call)
//       await Future.delayed(const Duration(seconds: 2));

//       // You would typically call your repository/service here
//       // final result = await formRepository.submitForm(state.fieldValues);

//       emit(
//         state.copyWith(
//           isSubmitting: false,
//           // You could add a success state here
//         ),
//       );

//       // Handle successful submission (e.g., navigation, showing success message)
//     } catch (e) {
//       emit(
//         state.copyWith(
//           isSubmitting: false,
//           error: AppErrorModel(
//             message: 'Failed to submit form: ${e.toString()}',
//           ),
//         ),
//       );
//     }
//   }

//   Future<void> _onGetFormEvent(
//     GetFormEvent event,
//     Emitter<DynamicFormState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true, error: null));

//     try {
//       // Simulate loading form data (replace with actual API call)
//       await Future.delayed(const Duration(seconds: 1));

//       // You would typically call your repository/service here
//       // final formData = await formRepository.getForm();

//       // For now, emit loading state - you'll need to implement actual data loading
//       emit(
//         state.copyWith(
//           isLoading: false,
//           error: AppErrorModel(
//             message: 'Form data loading not implemented yet',
//           ),
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           isLoading: false,
//           error: AppErrorModel(message: 'Failed to load form: ${e.toString()}'),
//         ),
//       );
//     }
//   }

//   Future<void> _onResetFormEvent(
//     ResetFormEvent event,
//     Emitter<DynamicFormState> emit,
//   ) async {
//     if (state.form == null) return;

//     // Reset to initial values
//     final Map<String, dynamic> initialValues = {};
//     for (final step in state.form!.steps) {
//       for (final input in step.inputs) {
//         if (input.effectiveDefault != null) {
//           initialValues[input.key] = input.effectiveDefault;
//         }
//       }
//     }

//     emit(
//       state.copyWith(
//         currentStepIndex: 0,
//         fieldValues: initialValues,
//         fieldErrors: {},
//         isCurrentStepValid: false,
//         isFormValid: false,
//         error: null,
//       ),
//     );

//     // Validate the first step
//     add(const ValidateCurrentStepEvent());
//   }

//   Future<bool> _validateCurrentStep() async {
//     if (state.form == null || state.currentStep == null) return false;

//     final currentStep = state.currentStep!;
//     final errors = <String, String>{};

//     for (final input in currentStep.inputs) {
//       final value = state.getFieldValue(input.key, input);
//       final error = _validateField(input, value);
//       if (error != null) {
//         errors[input.key] = error;
//       }
//     }

//     // Update field errors for current step
//     final updatedErrors = Map<String, String>.from(state.fieldErrors);

//     // Remove errors for current step fields
//     for (final input in currentStep.inputs) {
//       updatedErrors.remove(input.key);
//     }

//     // Add new errors
//     updatedErrors.addAll(errors);

//     if (errors.isNotEmpty) {
//       emit(state.copyWith(fieldErrors: updatedErrors));
//     }

//     return errors.isEmpty;
//   }

//   Future<bool> _validateAllSteps() async {
//     if (state.form == null) return false;

//     final errors = <String, String>{};

//     for (final step in state.form!.steps) {
//       for (final input in step.inputs) {
//         final value = state.getFieldValue(input.key, input);
//         final error = _validateField(input, value);
//         if (error != null) {
//           errors[input.key] = error;
//         }
//       }
//     }

//     return errors.isEmpty;
//   }

//   String? _validateField(FormInput input, dynamic value) {
//     // Required field validation
//     if (input.required && (value == null || value.toString().trim().isEmpty)) {
//       return '${input.label} is required';
//     }

//     // Skip further validation if field is empty and not required
//     if (value == null || value.toString().trim().isEmpty) {
//       return null;
//     }

//     final stringValue = value.toString();
//     final validation = input.validation;

//     if (validation != null) {
//       // Number only validation
//       if (validation.numberOnly == true) {
//         if (double.tryParse(stringValue) == null) {
//           return '${input.label} must be a valid number';
//         }
//       }

//       // Min length validation
//       if (validation.minLength != null &&
//           stringValue.length < validation.minLength!) {
//         return '${input.label} must be at least ${validation.minLength} characters';
//       }

//       // Max length validation
//       if (validation.maxLength != null &&
//           stringValue.length > validation.maxLength!) {
//         return '${input.label} must not exceed ${validation.maxLength} characters';
//       }

//       // Pattern validation
//       if (validation.pattern != null) {
//         final regex = RegExp(validation.pattern!);
//         if (!regex.hasMatch(stringValue)) {
//           return '${input.label} format is invalid';
//         }
//       }
//     }

//     // Type-specific validations
//     switch (input.type.toLowerCase()) {
//       case 'email':
//         final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
//         if (!emailRegex.hasMatch(stringValue)) {
//           return 'Please enter a valid email address';
//         }
//         break;
//       case 'phone':
//         final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');
//         if (!phoneRegex.hasMatch(stringValue)) {
//           return 'Please enter a valid phone number';
//         }
//         break;
//     }

//     return null;
//   }
// }
