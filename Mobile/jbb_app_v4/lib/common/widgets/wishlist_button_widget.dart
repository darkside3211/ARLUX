import 'package:flutter/material.dart';

abstract class WishlistButtonWidget {}

class WishlistButtonNonAvatar extends StatefulWidget
    implements WishlistButtonWidget {
  const WishlistButtonNonAvatar({super.key, this.isWished = false});

  final bool isWished;

  @override
  State<WishlistButtonNonAvatar> createState() =>
      _WishlistButtonNonAvatarState();
}

class _WishlistButtonNonAvatarState extends State<WishlistButtonNonAvatar> {
  bool wished = false;

  @override
  void initState() {
    super.initState();
    wished = widget.isWished;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          wished = !wished;
        });
      },
      icon: wished
          ? const Icon(
              Icons.favorite,
              color: Colors.amber,
            )
          : const Icon(
              Icons.favorite_border_outlined,
              color: Colors.black,
            ),
    );
  }
}

class WishlistButtonAvatar extends StatefulWidget {
  const WishlistButtonAvatar({super.key, this.isWished = false});

  final bool isWished;

  @override
  State<WishlistButtonAvatar> createState() => _WishlistButtonAvatarState();
}

class _WishlistButtonAvatarState extends State<WishlistButtonAvatar> {
  bool wished = false;

  @override
  void initState() {
    super.initState();
    wished = widget.isWished;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          wished = !wished;
        });
      },
      child: CircleAvatar(
        backgroundColor: Colors.black,
        child: wished
            ? const Icon(
                Icons.favorite,
                color: Colors.amber,
              )
            : const Icon(
                Icons.favorite_border_outlined,
                color: Colors.amber,
              ),
      ),
    );
  }
}
