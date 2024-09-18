import 'package:flutter/material.dart';
import 'package:jbb_app_v4/common/widgets/cart_button_widget.dart';

class BottomBuyCartBar extends StatelessWidget {
  const BottomBuyCartBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.amber, width: 2.0))),
      child: BottomAppBar(
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(onPressed: () {}, icon: const Icon(Icons.help)),
              IconButton(
                icon: const Icon(Icons.chat),
                onPressed: () {
                  // Handle chat icon button press
                },
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle Buy Now button press
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: const Color(0xff292929)),
                    child: const Text('Buy Now'),
                  ),
                  const SizedBox(width: 8.0),
                  const CartElevatedButtonWidget(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
