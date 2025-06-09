// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../bloc/form.bloc.dart';
// import '../../data/model/form.model.dart';
// import '../../data/model/form_input.model.dart';
// import '../../data/model/form_step.model.dart';
// import '../../data/model/form_validation.model.dart';

// @RoutePage(name: 'FormPageRoute')
// class FormPage extends StatelessWidget {
//   const FormPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => FormBloc()..add(LoadFormEvent(_getSampleFormData())),
//       child: const FormView(),
//     );
//   }

//   // Sample form data - replace with actual data loading
//   FormData _getSampleFormData() {
//     return FormData(
//       title: 'Sample Dynamic Form',
//       steps: [
//         FormStep(
//           title: 'Personal Information',
//           description: 'Please provide your personal details',
//           inputs: [
//             FormInput(
//               key: 'firstName',
//               type: 'text',
//               label: 'First Name',
//               required: true,
//               validation: FormValidation(minLength: 2, maxLength: 50),
//             ),
//             FormInput(
//               key: 'lastName',
//               type: 'text',
//               label: 'Last Name',
//               required: true,
//               validation: FormValidation(minLength: 2, maxLength: 50),
//             ),
//             FormInput(
//               key: 'email',
//               type: 'email',
//               label: 'Email Address',
//               required: true,
//             ),
//             FormInput(
//               key: 'phone',
//               type: 'phone',
//               label: 'Phone Number',
//               required: false,
//             ),
//           ],
//         ),
//         FormStep(
//           title: 'Preferences',
//           description: 'Tell us about your preferences',
//           inputs: [
//             FormInput(
//               key: 'notifications',
//               type: 'select',
//               label: 'Notification Preference',
//               required: true,
//               options: ['Email', 'SMS', 'Push', 'None'],
//               defaultValue: 'Email',
//             ),
//             FormInput(
//               key: 'interests',
//               type: 'multiselect',
//               label: 'Interests',
//               required: false,
//               options: ['Technology', 'Sports', 'Music', 'Travel', 'Food'],
//             ),
//             FormInput(
//               key: 'bio',
//               type: 'textarea',
//               label: 'Bio',
//               required: false,
//               validation: FormValidation(maxLength: 500),
//             ),
//           ],
//         ),
//         FormStep(
//           title: 'Additional Information',
//           description: 'Final details',
//           inputs: [
//             FormInput(
//               key: 'age',
//               type: 'number',
//               label: 'Age',
//               required: true,
//               validation: FormValidation(numberOnly: true),
//             ),
//             FormInput(
//               key: 'terms',
//               type: 'checkbox',
//               label: 'I agree to the terms and conditions',
//               required: true,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class FormView extends StatelessWidget {
//   const FormView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: BlocBuilder<FormBloc, DynamicFormState>(
//           builder: (context, state) {
//             return Text(state.form?.title ?? 'Dynamic Form');
//           },
//         ),
//         actions: [
//           BlocBuilder<FormBloc, DynamicFormState>(
//             builder: (context, state) {
//               if (state.form == null) return const SizedBox.shrink();

//               return PopupMenuButton<String>(
//                 onSelected: (value) {
//                   switch (value) {
//                     case 'reset':
//                       context.read<FormBloc>().add(const ResetFormEvent());
//                       break;
//                   }
//                 },
//                 itemBuilder: (context) => [
//                   const PopupMenuItem(
//                     value: 'reset',
//                     child: Row(
//                       children: [
//                         Icon(Icons.refresh),
//                         SizedBox(width: 8),
//                         Text('Reset Form'),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//       body: BlocBuilder<FormBloc, DynamicFormState>(
//         builder: (context, state) {
//           if (state.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (state.error != null) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.error_outline,
//                     size: 64,
//                     color: Colors.red.shade400,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Error',
//                     style: Theme.of(context).textTheme.headlineSmall,
//                   ),
//                   const SizedBox(height: 8),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 32),
//                     child: Text(
//                       state.error!.message,
//                       textAlign: TextAlign.center,
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   ElevatedButton(
//                     onPressed: () {
//                       context.read<FormBloc>().add(const GetFormEvent());
//                     },
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           if (state.form == null) {
//             return const Center(child: Text('No form data available'));
//           }

//           return Column(
//             children: [
//               // Progress indicator
//               _buildProgressIndicator(context, state),

//               // Form content
//               Expanded(child: _buildFormContent(context, state)),

//               // Navigation buttons
//               _buildNavigationButtons(context, state),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildProgressIndicator(BuildContext context, DynamicFormState state) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Text(
//                 'Step ${state.currentStepIndex + 1} of ${state.totalSteps}',
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               const Spacer(),
//               Text(
//                 '${((state.currentStepIndex + 1) / state.totalSteps * 100).round()}%',
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           LinearProgressIndicator(
//             value: (state.currentStepIndex + 1) / state.totalSteps,
//             backgroundColor: Colors.grey.shade300,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFormContent(BuildContext context, DynamicFormState state) {
//     final currentStep = state.currentStep;
//     if (currentStep == null) return const SizedBox.shrink();

//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Step header
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     currentStep.title,
//                     style: Theme.of(context).textTheme.headlineSmall,
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     currentStep.description,
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           const SizedBox(height: 16),

//           // Form fields
//           ...currentStep.inputs.map(
//             (input) => Padding(
//               padding: const EdgeInsets.only(bottom: 16),
//               child: _buildFormField(context, state, input),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFormField(
//     BuildContext context,
//     DynamicFormState state,
//     FormInput input,
//   ) {
//     final value = state.getFieldValue(input.key, input);
//     final hasError = state.hasFieldError(input.key);
//     final errorText = state.getFieldError(input.key);

//     switch (input.type.toLowerCase()) {
//       case 'text':
//       case 'email':
//       case 'phone':
//         return TextFormField(
//           initialValue: value?.toString() ?? '',
//           decoration: InputDecoration(
//             labelText: input.label,
//             hintText: 'Enter ${input.label.toLowerCase()}',
//             errorText: hasError ? errorText : null,
//             border: const OutlineInputBorder(),
//             prefixIcon: _getFieldIcon(input.type),
//           ),
//           keyboardType: _getKeyboardType(input.type),
//           onChanged: (newValue) {
//             context.read<FormBloc>().add(
//               UpdateFieldValueEvent(fieldKey: input.key, value: newValue),
//             );
//           },
//         );

//       case 'number':
//         return TextFormField(
//           initialValue: value?.toString() ?? '',
//           decoration: InputDecoration(
//             labelText: input.label,
//             hintText: 'Enter ${input.label.toLowerCase()}',
//             errorText: hasError ? errorText : null,
//             border: const OutlineInputBorder(),
//             prefixIcon: const Icon(Icons.numbers),
//           ),
//           keyboardType: TextInputType.number,
//           onChanged: (newValue) {
//             context.read<FormBloc>().add(
//               UpdateFieldValueEvent(fieldKey: input.key, value: newValue),
//             );
//           },
//         );

//       case 'textarea':
//         return TextFormField(
//           initialValue: value?.toString() ?? '',
//           decoration: InputDecoration(
//             labelText: input.label,
//             hintText: 'Enter ${input.label.toLowerCase()}',
//             errorText: hasError ? errorText : null,
//             border: const OutlineInputBorder(),
//             alignLabelWithHint: true,
//           ),
//           maxLines: 4,
//           onChanged: (newValue) {
//             context.read<FormBloc>().add(
//               UpdateFieldValueEvent(fieldKey: input.key, value: newValue),
//             );
//           },
//         );

//       case 'select':
//         return DropdownButtonFormField<String>(
//           value: value?.toString(),
//           decoration: InputDecoration(
//             labelText: input.label,
//             errorText: hasError ? errorText : null,
//             border: const OutlineInputBorder(),
//             prefixIcon: const Icon(Icons.arrow_drop_down),
//           ),
//           items: input.options?.map((option) {
//             return DropdownMenuItem<String>(value: option, child: Text(option));
//           }).toList(),
//           onChanged: (newValue) {
//             if (newValue != null) {
//               context.read<FormBloc>().add(
//                 UpdateFieldValueEvent(fieldKey: input.key, value: newValue),
//               );
//             }
//           },
//         );

//       case 'multiselect':
//         final selectedValues = value is List
//             ? value.cast<String>()
//             : <String>[];
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(input.label, style: Theme.of(context).textTheme.bodyMedium),
//             if (hasError) ...[
//               const SizedBox(height: 4),
//               Text(
//                 errorText!,
//                 style: TextStyle(
//                   color: Theme.of(context).colorScheme.error,
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//             const SizedBox(height: 8),
//             ...input.options?.map((option) {
//                   final isSelected = selectedValues.contains(option);
//                   return CheckboxListTile(
//                     title: Text(option),
//                     value: isSelected,
//                     onChanged: (checked) {
//                       final newSelection = List<String>.from(selectedValues);
//                       if (checked == true) {
//                         newSelection.add(option);
//                       } else {
//                         newSelection.remove(option);
//                       }
//                       context.read<FormBloc>().add(
//                         UpdateFieldValueEvent(
//                           fieldKey: input.key,
//                           value: newSelection,
//                         ),
//                       );
//                     },
//                   );
//                 }) ??
//                 [],
//           ],
//         );

//       case 'checkbox':
//         return CheckboxListTile(
//           title: Text(input.label),
//           subtitle: hasError
//               ? Text(
//                   errorText!,
//                   style: TextStyle(
//                     color: Theme.of(context).colorScheme.error,
//                     fontSize: 12,
//                   ),
//                 )
//               : null,
//           value: value == true,
//           onChanged: (checked) {
//             context.read<FormBloc>().add(
//               UpdateFieldValueEvent(
//                 fieldKey: input.key,
//                 value: checked ?? false,
//               ),
//             );
//           },
//         );

//       default:
//         return TextFormField(
//           initialValue: value?.toString() ?? '',
//           decoration: InputDecoration(
//             labelText: input.label,
//             hintText: 'Enter ${input.label.toLowerCase()}',
//             errorText: hasError ? errorText : null,
//             border: const OutlineInputBorder(),
//           ),
//           onChanged: (newValue) {
//             context.read<FormBloc>().add(
//               UpdateFieldValueEvent(fieldKey: input.key, value: newValue),
//             );
//           },
//         );
//     }
//   }

//   Widget _buildNavigationButtons(BuildContext context, DynamicFormState state) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Theme.of(context).scaffoldBackgroundColor,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 4,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Previous button
//           if (!state.isFirstStep)
//             Expanded(
//               child: OutlinedButton.icon(
//                 onPressed: state.isSubmitting
//                     ? null
//                     : () {
//                         context.read<FormBloc>().add(const PreviousStepEvent());
//                       },
//                 icon: const Icon(Icons.arrow_back),
//                 label: const Text('Previous'),
//               ),
//             ),

//           if (!state.isFirstStep) const SizedBox(width: 16),

//           // Next/Submit button
//           Expanded(
//             child: state.isLastStep
//                 ? ElevatedButton.icon(
//                     onPressed: state.isSubmitting || !state.isFormValid
//                         ? null
//                         : () {
//                             context.read<FormBloc>().add(
//                               const SubmitFormEvent(),
//                             );
//                           },
//                     icon: state.isSubmitting
//                         ? const SizedBox(
//                             width: 16,
//                             height: 16,
//                             child: CircularProgressIndicator(strokeWidth: 2),
//                           )
//                         : const Icon(Icons.send),
//                     label: Text(
//                       state.isSubmitting ? 'Submitting...' : 'Submit',
//                     ),
//                   )
//                 : ElevatedButton.icon(
//                     onPressed: state.isSubmitting || !state.isCurrentStepValid
//                         ? null
//                         : () {
//                             context.read<FormBloc>().add(const NextStepEvent());
//                           },
//                     icon: const Icon(Icons.arrow_forward),
//                     label: const Text('Next'),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Icon? _getFieldIcon(String type) {
//     switch (type.toLowerCase()) {
//       case 'email':
//         return const Icon(Icons.email);
//       case 'phone':
//         return const Icon(Icons.phone);
//       case 'text':
//         return const Icon(Icons.text_fields);
//       default:
//         return null;
//     }
//   }

//   TextInputType _getKeyboardType(String type) {
//     switch (type.toLowerCase()) {
//       case 'email':
//         return TextInputType.emailAddress;
//       case 'phone':
//         return TextInputType.phone;
//       case 'number':
//         return TextInputType.number;
//       default:
//         return TextInputType.text;
//     }
//   }
// }
