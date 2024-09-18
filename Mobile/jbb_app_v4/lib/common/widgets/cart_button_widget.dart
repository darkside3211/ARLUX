import 'package:flutter/material.dart';

abstract class CartButtonWidget {}

class CartIconButtonWidget extends StatefulWidget implements CartButtonWidget {
  const CartIconButtonWidget({super.key, this.isCart = false});

  final bool isCart;

  @override
  State<CartIconButtonWidget> createState() => _CartIconButtonWidgetState();
}

class _CartIconButtonWidgetState extends State<CartIconButtonWidget> {
  bool carted = false;

  @override
  void initState() {
    super.initState();
    carted = widget.isCart;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          carted = !carted;
        });
      },
      icon: carted
          ? const Icon(
              Icons.shopping_bag,
              color: Colors.amber,
            )
          : const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
            ),
    );
  }
}

class CartElevatedButtonWidget extends StatelessWidget {
  const CartElevatedButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle Add to Cart button press
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff292929),
          foregroundColor: Colors.amber),
      child: const Text('Add to Cart'),
    );
  }
}
