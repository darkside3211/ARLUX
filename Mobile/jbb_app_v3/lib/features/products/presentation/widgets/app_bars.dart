import 'package:flutter/material.dart';

class AppBars {
  TextEditingController searchController = TextEditingController();

  String? _querySearch;

  String? getSearchQuery(String? query) {
    _querySearch = query;
    return _querySearch;
  }

  AppBar appBarWithSearchBar() {
    return AppBar(
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextField(
          controller: searchController,
          onSubmitted: (value) {
            getSearchQuery(value);
          },
          onChanged: (value) {},
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
                onPressed: () {
                  searchController.clear();
                },
                icon: const Icon(Icons.disabled_by_default_rounded)),
            hintText: 'Search...Jewelry',
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.sort),
        ),
      ],
    );
  }

  AppBar appBarWishCart(BuildContext context, {String? title}) {
    return AppBar(
      title: Text(
        title ?? "Title",
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      backgroundColor: Colors.transparent,
      leading: Container(
        color: Colors.grey[850]?.withAlpha(155),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.amber,
          ),
        ),
      ),
      actions: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[850],
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.amber,
                ),
                color: Colors.grey[850],
              ),
              const SizedBox(width: 8),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.amber,
                  ))
            ],
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget bottomBuyCartBar() {
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
                  ElevatedButton(
                    onPressed: () {
                      // Handle Add to Cart button press
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff292929),
                        foregroundColor: Colors.amber),
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
}
