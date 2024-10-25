import 'package:flutter/material.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';

class ProductBottomSheet extends StatefulWidget {
  final String label;
  final List<String>? sizes;
  final Function(int quantity, String size) onPressed;
  const ProductBottomSheet(
      {super.key, required this.onPressed, required this.label, this.sizes});

  @override
  State<ProductBottomSheet> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProductBottomSheet> {
  @override
  Widget build(BuildContext context) {
    int quantity = 1;
    String selectedSize = 'M';
    final List<String> sizes = widget.sizes ?? ['S', 'M', 'L', 'XL'];

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
                        if (quantity > 1) quantity--;
                      });
                    },
                  ),
                  Text(
                    '$quantity',
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        quantity++;
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
                value: selectedSize,
                items: sizes.map((String size) {
                  return DropdownMenuItem<String>(
                    value: size,
                    child: Text(size),
                  );
                }).toList(),
                onChanged: (newSize) {
                  setState(() {
                    selectedSize = newSize!;
                  });
                },
              ),
            ],
          ),
          gapH32,
          ElevatedButton(
            onPressed: widget.onPressed(quantity, selectedSize),
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff292929),
                foregroundColor: AppColors.yellow),
            child: Text(widget.label),
          )
        ],
      ),
    );
  }
}
