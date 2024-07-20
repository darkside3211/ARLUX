import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jbb_application/components/ratings_builder.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductDetailPanel extends StatefulWidget {
  final ScrollController controller;
  final PanelController panelController;

  const ProductDetailPanel(
      {super.key, required this.controller, required this.panelController});

  @override
  State<ProductDetailPanel> createState() => _ProductDetailPanelState();
}

class _ProductDetailPanelState extends State<ProductDetailPanel> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      controller: widget.controller,
      children: <Widget>[
        const SizedBox(
          height: 16,
        ),
        buildDragHandle(),
        const SizedBox(
          height: 16,
        ),
        buildproductName(),
      ],
    );
  }

  Widget buildproductName() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: [
              Expanded(
                child: Text('P2,600.00',
                      style: GoogleFonts.dmSans(
                          color: Colors.amber,
                          textStyle: Theme.of(context).textTheme.headlineSmall,
                          fontWeight: FontWeight.bold)),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border_outlined)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.share))
            ]),
            Text('18k Mini Diamond Heart Ring',
                  style: GoogleFonts.dmSans(
                      textStyle: Theme.of(context).textTheme.headlineMedium,
                      fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'In stock: 86',
                  style: GoogleFonts.dmSans(
                    textStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const RatingsBuilder(rating: 3.5),
              ],
            ),
            const Divider(
              height: 32,
              color: Colors.amber,
            ),
            const Text('Sizes'),
            const SizedBox(height: 18),
            const RingSizes(),
            const SizedBox(height: 36,),
            Text('Details', style: GoogleFonts.dmSans(
              textStyle: Theme.of(context).textTheme.headlineMedium,
            ),),
            const Text('We sell per piece not per grm'),
            const Text('Free boxes!'),
            
            const Divider(
              height: 32,
              color: Colors.amber,
            )
          ],
        ),
      );

  Widget buildDragHandle() => GestureDetector(
        onTap: togglePanel,
        child: Center(
          child: Container(
            width: 30,
            height: 8,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8)),
          ),
        ),
      );

  void togglePanel() => widget.panelController.isPanelOpen
      ? widget.panelController.close()
      : widget.panelController.open();
}

class RingSizes extends StatefulWidget {
  const RingSizes({
    super.key,
  });

  @override
  State<RingSizes> createState() => _RingSizesState();
}

class _RingSizesState extends State<RingSizes> {
  String selectedButton = '';

  Row ringSizeButton(String ringSize) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        OutlinedButton(
            onPressed: () {
              setState(() {
                selectedButton = ringSize;
              });
            },
            style: TextButton.styleFrom(
                backgroundColor:
                    selectedButton == ringSize ? Colors.amber : Colors.white,
                foregroundColor: selectedButton == ringSize
                    ? Colors.black
                    : Colors.grey[600],
                shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero)),
            child: Text(ringSize)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) {
            String size = (index + 5).toString();
            return ringSizeButton(size);
          }),
    );
  }
}
