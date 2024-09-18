import 'package:flutter/material.dart';

abstract class HomeAppBar {}

class HomeTopBar extends StatelessWidget
    implements HomeAppBar, PreferredSizeWidget {
  final bool isDefault;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onNotificationPressed;

  const HomeTopBar({
    super.key,
    required this.isDefault,
    this.onMenuPressed,
    this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff292929),
      shadowColor: Colors.grey,
      elevation: 8,
      iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.amber),
      title: Image.asset(
        'assets/icons/logo.jpeg',
        width: 120,
        height: 120,
      ),
      centerTitle: true,
      leading: isDefault
          ? IconButton(
              onPressed: () {
                //Menu button
                onMenuPressed;
              },
              icon: const Icon(Icons.menu),
            )
          : IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
      actions: [
        IconButton(
          onPressed: () {
            //Notification
            onNotificationPressed;
          },
          icon: const Icon(Icons.notifications),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.blueGrey[800], // Background color of the bar
      selectedItemColor: Colors.amber, // Color of the selected item
      unselectedItemColor: Colors.grey[400],
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          label: 'Bag',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Account',
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
