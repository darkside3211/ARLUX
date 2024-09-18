import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff292929),
        title: Image.asset(
          'assets/images/jbb_logo.jpeg',
          alignment: Alignment.center,
          height: 64,
        ),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.shopping_bag_outlined))
        ],
      ),
      body: const HomePageBody(),
      bottomNavigationBar:
          BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Message'),
        BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Browse'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined), label: 'Account')
      ]),
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: Colors.amberAccent.shade700,
                  ),
                  hintText: 'Search...',
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(8)))),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                height: 4,
                color: Colors.amber,
              ),
            ),
            const ImageSlider(images: [
              'assets/miniDiamondHeartRing01.jpeg',
              'assets/miniDiamondHeartRing02.jpeg',
              'assets/miniDiamondHeartRing03.jpeg',
              'assets/miniDiamondHeartRing03.jpeg',
            ]),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                height: 4,
                color: Colors.amber,
              ),
            ),
            const Text(
              'Categories',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const JewelryCategories(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                height: 4,
                color: Colors.amber,
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Best Selling',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Text('See all'),
              ],
            ),
            const Placeholder(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                height: 4,
                color: Colors.amber,
              ),
            ),
            const Text(
              'New Arrivals',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const Placeholder(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                height: 4,
                color: Colors.amber,
              ),
            ),
            const Text(
              'Popular Products',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const Placeholder(),
          ],
        ),
      ),
    );
  }
}

class ImageSlider extends StatefulWidget {
  final List<String> images;

  const ImageSlider({super.key, required this.images});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _startAutoSlide();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _timer.cancel();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < widget.images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 256,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          return Image.asset(
            widget.images[index],
            fit: BoxFit.fitWidth,
          );
        },
      ),
    );
  }
}

class JewelryCategories extends StatelessWidget {
  const JewelryCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
