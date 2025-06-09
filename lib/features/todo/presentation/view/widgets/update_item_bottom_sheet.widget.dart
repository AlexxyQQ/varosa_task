import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class UpdateItemBottomSheet extends StatefulWidget {
  final ItemModel? item; // Optional item for update, null for create

  const UpdateItemBottomSheet({super.key, this.item});

  @override
  State<UpdateItemBottomSheet> createState() => _UpdateItemBottomSheetState();

  static Future<void> show({required BuildContext context, ItemModel? item}) {
    return AppBottomSheet.show(
      backgroundColor: PrimitiveColors.white,
      context: context,
      padding: AppSize.allPadding16,
      child: UpdateItemBottomSheet(item: item),
    );
  }
}

class _UpdateItemBottomSheetState extends State<UpdateItemBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  ItemStatus _selectedStatus = ItemStatus.backlog; // Default to backlog

  bool get isUpdating => widget.item != null;

  @override
  void initState() {
    super.initState();
    // Pre-populate fields if updating an existing item
    if (isUpdating) {
      _nameController.text = widget.item!.name ?? '';
      _descriptionController.text = widget.item!.description ?? '';
      _selectedStatus = widget.item!.status ?? ItemStatus.backlog;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitItem() {
    if (_formKey.currentState!.validate()) {
      final now = DateTime.now();

      if (isUpdating) {
        // Update existing item
        final updatedItem = widget.item!.copyWith(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          status: _selectedStatus,
          updatedAt: now,
        );

        context.read<ItemBloc>().add(UpdateEntityEvent(entity: updatedItem));
      } else {
        // Create new item
        final item = ItemModel.create(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          status: _selectedStatus,
        );

        context.read<ItemBloc>().add(CreateEntityEvent(entity: item));
      }

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
          Text(
            isUpdating ? 'Update Item' : 'Add New Item',
            style: AppTextStyles.headline,
          ),
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
                  onPressed: _submitItem,
                  label: isUpdating ? 'Update Item' : 'Create Item',
                ),
              ),
            ],
          ),
          AppSize.verticalMargin24,
        ],
      ),
    );
  }
}
