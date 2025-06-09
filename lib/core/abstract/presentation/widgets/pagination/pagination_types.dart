/// Common types and enums used across pagination widgets
library;

enum PaginationControlsPosition { top, bottom }

/// Filter item model for the filterable pagination
class FilterItem {
  final String key;
  final String label;
  final dynamic value;
  final bool isSelected;

  const FilterItem({
    required this.key,
    required this.label,
    required this.value,
    this.isSelected = false,
  });

  FilterItem copyWith({
    String? key,
    String? label,
    dynamic value,
    bool? isSelected,
  }) {
    return FilterItem(
      key: key ?? this.key,
      label: label ?? this.label,
      value: value ?? this.value,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
