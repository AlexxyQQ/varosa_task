// part of 'form.bloc.dart';

// @freezed
// abstract class DynamicFormState with _$FormState {
//   const DynamicFormState._();

//   const factory DynamicFormState({
//     @Default(false) bool isLoading,
//     @Default(false) bool isSubmitting,
//     @Default(0) int currentStepIndex,
//     @Default({}) Map<String, dynamic> fieldValues,
//     @Default({}) Map<String, String> fieldErrors,
//     @Default(false) bool isFormValid,
//     @Default(false) bool isCurrentStepValid,
//     AppErrorModel? error,
//     FormData? form,
//   }) = _FormState;

//   factory DynamicFormState.initial() => const DynamicFormState();

//   factory DynamicFormState.error(AppErrorModel error) => DynamicFormState(
//     error: error,
//     isLoading: false,
//     isSubmitting: false,
//     currentStepIndex: 0,
//     fieldValues: const {},
//     fieldErrors: const {},
//     isFormValid: false,
//     isCurrentStepValid: false,
//   );

//   // Helper getters
//   bool get isFirstStep => this.currentStepIndex == 0;
//   bool get isLastStep =>
//       this.form != null && this.currentStepIndex == this.form!.steps.length - 1;
//   int get totalSteps => this.form?.steps.length ?? 0;
//   FormStep? get currentStep =>
//       this.form != null && this.currentStepIndex < this.form!.steps.length
//       ? this.form!.steps[this.currentStepIndex]
//       : null;

//   // Get field value with fallback to default
//   dynamic getFieldValue(String key, FormInput input) {
//     return this.fieldValues[key] ?? input.effectiveDefault;
//   }

//   // Check if a specific field has an error
//   bool hasFieldError(String key) => this.fieldErrors.containsKey(key);

//   // Get error message for a specific field
//   String? getFieldError(String key) => this.fieldErrors[key];
// }
