import 'package:flutter/material.dart';
import 'package:jbb_app_v5/presentation/pages/home/product_listing.dart';
import 'package:jbb_app_v5/presentation/widgets/product_widgets/product_grid.dart';

class ProductSearchField extends StatefulWidget {
  final String initialText;

  const ProductSearchField({super.key, this.initialText = ""});

  @override
  State<ProductSearchField> createState() => _ProductSearchFieldState();
}

class _ProductSearchFieldState extends State<ProductSearchField> {
  final TextEditingController _controller = TextEditingController();

  String? _errorMessage;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  String? _validateInput(String text) {
    if (text.isEmpty) {
      return 'Search query cannot be empty.';
    } else if (text.length < 3) {
      return 'Query too short.';
    }
    return null;
  }

  void _handleSubmit(String value) {
    setState(() {
      _errorMessage = _validateInput(value);
    });

    if (_errorMessage == null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProductListing(
            productGrid:
                ProductSearchImpl(q: _controller.text, isScrollable: true),
            queryText: _controller.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialText.isNotEmpty) {
      _controller.text = widget.initialText;
    }
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, value, _) {
        return TextField(
          controller: _controller,
          autofocus: false,
          style: Theme.of(context).textTheme.titleSmall,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.amber),
            ),
            labelStyle: TextStyle(color: Colors.amber[100]),
            filled: true,
            fillColor: Colors.amber[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            hintText: 'Search jewelry...',
            icon: const Icon(Icons.search),
            errorText: _errorMessage,
            suffixIcon: value.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      setState(
                        () {
                          _controller.clear();
                          _errorMessage = null;
                        },
                      );
                    },
                    icon: const Icon(Icons.clear),
                  )
                : null,
          ),
          onSubmitted: _handleSubmit,
        );
      },
    );
  }
}
