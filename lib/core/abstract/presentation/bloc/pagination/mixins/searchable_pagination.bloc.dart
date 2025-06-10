import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../../../common/presentation/helpers/debounce.helper.dart';
import '../pagination.bloc.dart';

mixin SearchablePaginationBloc<T> on PaginationBloc<T> {
  late final TextEditingController searchController = TextEditingController();
  late final DebouncerHelper _searchDebouncer = DebouncerHelper(
    duration: const Duration(milliseconds: 500),
  );

  void initializeSearch() {
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    _searchDebouncer(() {
      final searchQuery = searchController.text.trim();
      final updatedFilters = Map<String, dynamic>.from(state.filters ?? {});

      if (searchQuery.isNotEmpty) {
        updatedFilters['search'] = searchQuery;
      } else {
        updatedFilters.remove('search');
      }
      add(UpdateFiltersPaginationEvent(updatedFilters, refresh: true));
    });
  }

  void clearSearch() {
    searchController.clear();
    add(const LoadInitialPaginationEvent());
  }

  void setSearchQuery(String query) {
    searchController.text = query;
  }

  String get currentSearchQuery => searchController.text.trim();

  bool get hasSearchQuery => currentSearchQuery.isNotEmpty;

  @override
  void dispose() {
    try {
      _searchDebouncer.dispose();
      searchController.dispose();
    } catch (e) {
      log('SearchablePaginationBloc dispose error: $e');
    }
    super.dispose();
  }
}
