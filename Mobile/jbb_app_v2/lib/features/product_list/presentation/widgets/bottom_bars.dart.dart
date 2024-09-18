import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

Widget productDetailBottomBar(BuildContext context) {
  return Container(
    decoration:
        const BoxDecoration(border: Border(top: BorderSide(width: 2.0))),
    child: BottomAppBar(
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
                  child: const Text('Buy Now'),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle Add to Cart button press
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(FlexColor.amberLightPrimary),
                  ),
                  child: const Text('Add to Cart'),
                ),
              ],
            ))
          ],
        ),
      ),
    ),
  );
}
