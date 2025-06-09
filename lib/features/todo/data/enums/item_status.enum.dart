import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/abstract/presentation/abstract.app_color.dart';

part 'item_status.enum.g.dart';

@JsonEnum(alwaysCreate: true)
enum ItemStatus {
  @JsonValue("in-progress")
  inProgress,
  @JsonValue("completed")
  completed,
  @JsonValue("archived")
  archived,
  @JsonValue("backlog")
  backlog;

  String toJson() => _$ItemStatusEnumMap[this]!;

  static ItemStatus? fromString(String value) => _$ItemStatusEnumMap.entries
      .firstWhere(
        (element) => element.value.toLowerCase() == value.toLowerCase(),
      )
      .key;

  String get name {
    return switch (this) {
      ItemStatus.inProgress => "In Progress",
      ItemStatus.completed => "Completed",
      ItemStatus.archived => "Archived",
      ItemStatus.backlog => "Backlog",
    };
  }

  Color get backgroundColor {
    return switch (this) {
      ItemStatus.inProgress => const CustomAppColor(
        0xFF2196F3,
      ).withValues(alpha: 0.1),
      ItemStatus.completed => const CustomAppColor(
        0xFF4CAF50,
      ).withValues(alpha: 0.1),
      ItemStatus.archived => const CustomAppColor(
        0xFF9E9E9E,
      ).withValues(alpha: 0.1),
      ItemStatus.backlog => const CustomAppColor(
        0xFFF57C00,
      ).withValues(alpha: 0.1),
    };
  }

  Color get textColor {
    return switch (this) {
      ItemStatus.inProgress => const CustomAppColor(0xFF2196F3),
      ItemStatus.completed => const CustomAppColor(0xFF4CAF50),
      ItemStatus.archived => const CustomAppColor(0xFF9E9E9E),
      ItemStatus.backlog => const CustomAppColor(0xFFF57C00),
    };
  }

  IconData get icon {
    return switch (this) {
      ItemStatus.inProgress => Icons.play_circle_outline,
      ItemStatus.completed => Icons.check_circle_outline,
      ItemStatus.archived => Icons.archive_outlined,
      ItemStatus.backlog => Icons.schedule,
    };
  }
}
