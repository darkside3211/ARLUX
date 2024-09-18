import 'package:flutter/material.dart';
import 'package:jbb_app_v4/core/constants/filter_values.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/jewelry_list/jewelry_grid.dart';
import 'package:jbb_app_v4/features/jewelry/presentation/jewelry_screen/jewelry_list_result.dart';

class JewelrySearchField extends StatefulWidget {
  final String initalText;

  const JewelrySearchField({super.key, this.initalText = ""});

  @override
  State<JewelrySearchField> createState() => _JewelrySearchFieldState();
}

class _JewelrySearchFieldState extends State<JewelrySearchField> {
  final TextEditingController _controller = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _validateInput(String text) {
    if (text.isEmpty) {
      return "Search query cannot be empty";
    } else if (text.length < 3) {
      return "Query too short";
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
          builder: (context) => JewelryListResult(
            gridItems: JewelrySearchResultsImpl(
                isScrollable: true, q: _controller.text),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initalText.isNotEmpty) {
      _controller.text = widget.initalText;
    }

    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, value, _) {
        return TextField(
          controller: _controller,
          autofocus: false,
          style: Theme.of(context).textTheme.titleSmall,
          decoration: InputDecoration(
            hintText: 'Search jewelry...',
            icon: const Icon(Icons.search),
            errorText: _errorMessage, // Display error message here
            suffixIcon: value.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _controller.clear();
                        _errorMessage = null; // Clear error message
                      });
                    },
                    icon: const Icon(Icons.clear),
                  )
                : null,
          ),
          onSubmitted: _handleSubmit, // Handle submission
        );
      },
    );
  }
}

class SearchFilters extends StatefulWidget {
  final VoidCallback? onFilterPressed;

  const SearchFilters({super.key, this.onFilterPressed});

  @override
  State<SearchFilters> createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: jewelryCategories.length,
      itemBuilder: (context, index) {
        return ListTile(
          dense: true,
          title: Text(jewelryCategories[index]),
          onTap: widget.onFilterPressed,
        );
      },
    );
  }
}
