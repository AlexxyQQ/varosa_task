import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/app_text_style.dart';
import '../../../../../core/common/presentation/views/styles/form.style.dart';
import '../../../../../core/common/presentation/views/widgets/app_dropdown.widget.dart';
import '../../../../../core/common/presentation/views/widgets/app_switch.widget.dart';
import '../../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../../../../core/common/presentation/views/widgets/app_text_field.widget.dart';
import '../../../data/enum/input_type.enum.dart';
import '../../../data/model/form_input.model.dart';
import '../../bloc/form_state/form_state.bloc.dart';
import '../../bloc/post/post_dynamic_form.bloc.dart';

class FormInputWidget extends StatefulWidget {
  const FormInputWidget({
    super.key,
    required this.input,
    required this.onChanged,
  });
  final FormInputModel input;
  final Null Function(dynamic value) onChanged;

  @override
  State<FormInputWidget> createState() => _FormInputWidgetState();
}

class _FormInputWidgetState extends State<FormInputWidget> {
  late TextEditingController _textController;
  late AppDropdownController<String> _dropdownController;
  late AppSwitchController _switchController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final formStateBloc = context.read<FormStateBloc>();
    final currentState = formStateBloc.state;
    dynamic currentValue;

    if (currentState is FormStateLoaded && widget.input.key != null) {
      currentValue = currentState.formValues[widget.input.key];
    }

    // Initialize controllers based on input type
    switch (widget.input.type) {
      case InputType.toggle:
        final boolValue = currentValue is bool
            ? currentValue
            : (widget.input.defaultValue ??
                  widget.input.defaultValueAlt ??
                  false);
        _switchController = AppSwitchController(boolValue)
          ..addListener(() => widget.onChanged(boolValue));
      case InputType.dropdown:
        final stringValue = currentValue is String
            ? currentValue
            : (widget.input.defaultValue ?? widget.input.defaultValueAlt);
        _dropdownController = AppDropdownController<String>(stringValue)
          ..addListener(() => widget.onChanged(stringValue));
      default:
        final textValue =
            currentValue?.toString() ??
            (widget.input.defaultValue ?? widget.input.defaultValueAlt)
                ?.toString() ??
            '';
        _textController = TextEditingController(text: textValue)
          ..addListener(() => widget.onChanged(textValue));
    }
  }

  @override
  void dispose() {
    switch (widget.input.type) {
      case InputType.toggle:
        _switchController.dispose();
      case InputType.dropdown:
        _dropdownController.dispose();
      default:
        _textController.dispose();
    }
    super.dispose();
  }

  void _onValueChanged(dynamic value) {
    if (widget.input.key != null) {
      context.read<FormStateBloc>().add(
        UpdateFormValueEvent(key: widget.input.key!, value: value),
      );
    }
  }

  String? _getErrorText() {
    final formStateBloc = context.read<FormStateBloc>();
    final currentState = formStateBloc.state;

    if (currentState is FormStateLoaded && widget.input.key != null) {
      return currentState.errors[widget.input.key];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostDynamicFormBloc, PostDynamicFormState>(
      listener: (context, postState) {
        if (postState is PostDynamicFormSuccess) {
          // Clear form values
          _textController.clear();
          _dropdownController.value = '';
          _switchController.value = false;
          _initializeControllers();
        }
      },
      child: BlocBuilder<FormStateBloc, FormStateState>(
        builder: (context, formState) {
          final errorText = _getErrorText();

          return switch (widget.input.type) {
            InputType.text => AppTextField.custom(
              controller: _textController,
              onChanged: _onValueChanged,
              titleText: widget.input.label ?? '',
              hintText: widget.input.label ?? '',
              validator: (value) => errorText,
            ),
            InputType.dropdown => AppDropdown<String>(
              titleText: widget.input.label ?? '',
              hintText: widget.input.label ?? '',
              controller: _dropdownController,
              onChanged: _onValueChanged,
              validator: (value) => errorText,
              items:
                  widget.input.options
                      ?.map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: AppText(
                            e,
                            style: AppTextStyles.body.copyWith(
                              color: PrimitiveColors.black,
                            ),
                          ),
                        ),
                      )
                      .toList() ??
                  [],
            ),
            InputType.toggle => AppSwitch(
              titleText: widget.input.label ?? '',
              controller: _switchController,
              onChanged: _onValueChanged,
            ),
            InputType.number => AppTextField.custom(
              controller: _textController,
              onChanged: _onValueChanged,
              titleText: widget.input.label ?? '',
              hintText: widget.input.label ?? '',
              validator: (value) => errorText,
              theme: FormStyles.getTheme(null).copyWith(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            InputType.email => AppTextField.custom(
              controller: _textController,
              onChanged: _onValueChanged,
              titleText: widget.input.label ?? '',
              hintText: widget.input.label ?? '',
              validator: (value) => errorText,
              theme: FormStyles.getTheme(
                null,
              ).copyWith(keyboardType: TextInputType.emailAddress),
            ),
            InputType.phone => AppTextField.custom(
              controller: _textController,
              onChanged: _onValueChanged,
              titleText: widget.input.label ?? '',
              hintText: widget.input.label ?? '',
              validator: (value) => errorText,
              theme: FormStyles.getTheme(
                null,
              ).copyWith(keyboardType: TextInputType.phone),
            ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
