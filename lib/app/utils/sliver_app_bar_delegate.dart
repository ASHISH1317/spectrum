import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Sliver app bar delegate
class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  /// Sliver app bar delegate constructor
  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  /// Minimum height
  final double minHeight;

  /// Maximum height
  final double maxHeight;

  /// Child
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) =>
      SizedBox.expand(child: child);

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) =>
      maxHeight != oldDelegate.maxHeight ||
          minHeight != oldDelegate.minHeight ||
          child != oldDelegate.child;
}
