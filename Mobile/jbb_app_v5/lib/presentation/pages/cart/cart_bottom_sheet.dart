import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_buttons.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';

class CartBottomSheet extends ConsumerStatefulWidget {
  const CartBottomSheet({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CartBottomSheetState();
}

class _CartBottomSheetState extends ConsumerState<CartBottomSheet> {
  int _quantity = 1;
  String _selectedSize = 'M';
  final List<String> _sizes = ['S', 'M', 'L', 'XL'];

  @override
  Widget build(BuildContext context) {
    final productId = ref.watch(selectedProductIdProvider);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Select Quantity and Size",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          gapH20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Quantity",
                style: TextStyle(fontSize: 16),
              ),
              gapW8,
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (_quantity > 1) _quantity--;
                      });
                    },
                  ),
                  Text(
                    '$_quantity',
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          gapH20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Size",
                style: TextStyle(fontSize: 16),
              ),
              DropdownButton<String>(
                value: _selectedSize,
                items: _sizes.map((String size) {
                  return DropdownMenuItem<String>(
                    value: size,
                    child: Text(size),
                  );
                }).toList(),
                onChanged: (newSize) {
                  setState(() {
                    _selectedSize = newSize!;
                  });
                },
              ),
            ],
          ),
          gapH32,
          CartElevatedButton(
            isConfirm: true,
            customFunction: () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    const Center(child: CircularProgressIndicator()),
              );

              final isProductAdded = await ref.read(
                addProductToBagProvider(
                  productId: productId,
                  quantity: _quantity,
                  size: _selectedSize,
                ).future,
              );

              // ignore: use_build_context_synchronously
              Navigator.of(context, rootNavigator: true).pop();

              if (isProductAdded && context.mounted) {
                Navigator.pop(context);
                SnackBarFailure(context, message: "Successfully added to bag!");
              } else {
                ToastFailure(message: "Failed to add to bag.");
              }
            },
          ),
        ],
      ),
    );
  }
}
