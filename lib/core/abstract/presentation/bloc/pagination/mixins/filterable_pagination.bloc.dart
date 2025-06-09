import 'dart:developer';

import '../../../../../common/presentation/helpers/debounce.helper.dart';
import '../pagination.bloc.dart';

mixin FilterablePaginationBloc<T> on PaginationBloc<T> {
  late final DebouncerHelper _filterDebouncer = DebouncerHelper(
    duration: const Duration(milliseconds: 300),
  );

  /// Updates a single filter
  void updateFilter(String key, dynamic value, {bool refresh = true}) {
    _filterDebouncer(() {
      final updatedFilters = Map<String, dynamic>.from(state.filters ?? {});

      if (value == null || (value is String && value.isEmpty)) {
        updatedFilters.remove(key);
      } else {
        updatedFilters[key] = value;
      }

      add(UpdateFiltersPaginationEvent(updatedFilters, refresh: refresh));
    });
  }

  /// Updates multiple filters at once
  void updateFilters(Map<String, dynamic> newFilters, {bool refresh = true}) {
    _filterDebouncer(() {
      final updatedFilters = Map<String, dynamic>.from(state.filters ?? {});

      for (final entry in newFilters.entries) {
        if (entry.value == null ||
            (entry.value is String && entry.value.isEmpty)) {
          updatedFilters.remove(entry.key);
        } else {
          updatedFilters[entry.key] = entry.value;
        }
      }

      add(UpdateFiltersPaginationEvent(updatedFilters, refresh: refresh));
    });
  }

  /// Removes a specific filter
  void removeFilter(String key, {bool refresh = true}) {
    _filterDebouncer(() {
      final updatedFilters = Map<String, dynamic>.from(state.filters ?? {});
      updatedFilters.remove(key);

      add(UpdateFiltersPaginationEvent(updatedFilters, refresh: refresh));
    });
  }

  /// Removes multiple filters
  void removeFilters(List<String> keys, {bool refresh = true}) {
    _filterDebouncer(() {
      final updatedFilters = Map<String, dynamic>.from(state.filters ?? {});

      for (final key in keys) {
        updatedFilters.remove(key);
      }

      add(UpdateFiltersPaginationEvent(updatedFilters, refresh: refresh));
    });
  }

  /// Clears all filters
  void clearAllFilters({bool refresh = true}) {
    add(UpdateFiltersPaginationEvent({}, refresh: refresh));
  }

  /// Gets the value of a specific filter
  U? getFilterValue<U>(String key) {
    return state.filters?[key] as U?;
  }

  /// Checks if a specific filter exists and has a non-null value
  bool hasFilter(String key) {
    final value = state.filters?[key];
    return value != null && (value is! String || value.isNotEmpty);
  }

  /// Gets all current filters
  Map<String, dynamic> get currentFilters =>
      Map<String, dynamic>.from(state.filters ?? {});

  /// Checks if any filters are applied
  bool get hasAnyFilters => state.filters?.isNotEmpty == true;

  /// Gets the count of active filters
  int get activeFiltersCount => state.filters?.length ?? 0;

  @override
  void dispose() {
    try {
      _filterDebouncer.dispose();
    } catch (e) {
      log('FilterablePaginationBloc dispose error: $e');
    }
    super.dispose();
  }
}
