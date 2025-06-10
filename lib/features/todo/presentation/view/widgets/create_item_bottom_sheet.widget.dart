import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/app_text_style.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../../core/abstract/presentation/bloc/crud/crud.bloc.dart';
import '../../../../../core/common/presentation/views/widgets/app_bottom_sheet.widget.dart';
import '../../../../../core/common/presentation/views/widgets/app_button.widget.dart';
import '../../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../../data/enums/item_status.enum.dart';
import '../../../data/models/item.model.dart';
import '../../bloc/item.bloc.dart';

class CreateItemBottomSheet extends StatefulWidget {
  const CreateItemBottomSheet({super.key});

  @override
  State<CreateItemBottomSheet> createState() => _CreateItemBottomSheetState();
  static Future<void> show({required BuildContext context}) {
    return AppBottomSheet.show(
      backgroundColor: PrimitiveColors.white,
      context: context,
      padding: AppSize.allPadding16,
      child: const CreateItemBottomSheet(),
    );
  }
}

class _CreateItemBottomSheetState extends State<CreateItemBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  ItemStatus _selectedStatus = ItemStatus.backlog; // Default to backlog

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _createItem() {
    if (_formKey.currentState!.validate()) {
      final item = ItemModel.create(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        status: _selectedStatus,
      );

      context.read<ItemBloc>().add(CreateEntityEvent(entity: item));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add New Item', style: AppTextStyles.headline),
          AppSize.verticalMargin20,

          // Name Field
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'Enter item name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          AppSize.verticalMargin16,

          // Description Field
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description (Optional)',
              hintText: 'Enter item description',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          AppSize.verticalMargin16,

          // Status Field
          DropdownButtonFormField<ItemStatus>(
            value: _selectedStatus,
            decoration: const InputDecoration(
              labelText: 'Status',
              border: OutlineInputBorder(),
            ),
            items: ItemStatus.values.map((status) {
              return DropdownMenuItem<ItemStatus>(
                value: status,
                child: Row(
                  children: [
                    Icon(status.icon, color: status.textColor, size: 20),
                    AppSize.horizontalMargin8,
                    AppText(status.name),
                  ],
                ),
              );
            }).toList(),
            onChanged: (ItemStatus? value) {
              if (value != null) {
                setState(() {
                  _selectedStatus = value;
                });
              }
            },
          ),
          AppSize.verticalMargin24,

          // Buttons
          Row(
            children: [
              Expanded(
                child: AppButton.stroke(
                  onPressed: () => Navigator.of(context).pop(),
                  label: 'Cancel',
                ),
              ),
              AppSize.horizontalMargin16,
              Expanded(
                child: AppButton.primary(
                  onPressed: _createItem,
                  label: 'Create Item',
                ),
              ),
            ],
          ),
          AppSize.verticalMargin12,
        ],
      ),
    );
  }
}
