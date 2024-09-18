import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class CartWidget {
  final VoidCallback? onPressed;

  CartWidget({this.onPressed});
}

class AddtoCartBtnImpl extends ConsumerWidget implements CartWidget {
  @override
  final VoidCallback? onPressed;

  const AddtoCartBtnImpl({super.key, this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Text(
          'Add to Cart',
          style: Theme.of(context).textTheme.bodyMedium,
        ));
  }
}
