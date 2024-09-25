import 'package:flutter/material.dart';

abstract class Delegates {}

class SearchBarHeaderDelegate extends SliverPersistentHeaderDelegate implements Delegates {
  final Widget child;

  SearchBarHeaderDelegate({required this.child});

  @override
  double get minExtent => 70.0;

  @override
  double get maxExtent => 70.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SearchBarHeaderDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}

