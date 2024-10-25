import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/core/network/network_core.dart';
import 'package:jbb_app_v5/core/utils/formats.dart';
import 'package:jbb_app_v5/core/utils/terms.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/order/data/order_repository.dart';
import 'package:jbb_app_v5/presentation/pages/user/edit_user_page.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/carousels.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';

class UserPage extends ConsumerStatefulWidget {
  const UserPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage> {
  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authServiceProvider);
    final userInfo = ref.watch(getUserInfoProvider);
    final orders = ref.read(getOrdersProvider);
    final cartItems = ref.watch(bagItemCountProvider);
    final orderItems = ref.watch(orderStatusCountProvider);

    return userInfo.when(
      data: (user) {
        return RefreshIndicator(
          color: Colors.amber,
          onRefresh: () {
            return ref.refresh(getUserInfoProvider.future);
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Profile Picture and username
                Container(
                  decoration: const BoxDecoration(color: Color(0xff292929)),
                  alignment: Alignment.bottomLeft,
                  height: 128,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return EditUserPage(userInfo: user);
                          },
                        ),
                      );
                    },
                    child: ListTile(
                      iconColor: Colors.amber,
                      leading: CircleAvatar(
                        backgroundColor: Colors.amber.shade50,
                        radius: 30,
                        child: const Icon(Icons.account_circle),
                      ),
                      contentPadding: const EdgeInsets.all(8.0),
                      title: Text(
                        user.username ?? user.firebaseUid,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.yellow),
                      ),
                      trailing: const Icon(Icons.edit_note_rounded),
                      subtitle: Row(
                        children: [
                          Text(
                            'Cart Items: $cartItems',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white),
                          ),
                          gapW4,
                          const Text(" | "),
                          gapW4,
                          Text(
                            'Orders: ${orderItems.totalOrders}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (user.addresses.isEmpty ||
                    user.phone == null ||
                    user.username == null)
                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.notifications_active_outlined),
                    title: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Set shipping information to Checkout. ",
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Click here.",
                            style: const TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return EditUserPage(userInfo: user);
                                    },
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'My Purchases',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                gapH4,
                const UserPurchasesCarousel(),
                const Divider(
                  thickness: 8,
                  height: 36,
                ),
                ListTile(
                  onTap: () {
                    LaunchMessenger();
                  },
                  leading: const Icon(
                    Icons.support_agent_rounded,
                    size: 36,
                  ),
                  title: Text(
                    'Message Us',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                      'Help regarding your recent purchase or app usage.'),
                  dense: true,
                ),
                const Divider(
                  thickness: 8,
                  height: 36,
                ),
                ListTile(
                  onTap: () {
                    //TODO FAQs here
                  },
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                  ),
                  title: Text(
                    'FAQs',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  dense: true,
                ),
                ListTile(
                  onTap: () {
                    //TODO About us here
                  },
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                  ),
                  title: Text(
                    'About us',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  dense: true,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return Scaffold(
                            appBar: AppBar(),
                            body: const CreateTermsAndConditions(),
                          );
                        },
                      ),
                    );
                  },
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                  ),
                  title: Text(
                    'Terms and Privacy Policy',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  dense: true,
                ),
                const Divider(
                  thickness: 8,
                  height: 36,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Created: ${formatDate(user.createdAt)}",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Updated: ${formatDate(user.updatedAt)}",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                gapH8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: const BorderSide(width: 1),
                        ),
                        minimumSize: const Size(double.infinity, 60),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        //TODO delete account
                      },
                      child: Text(
                        "Delete Account",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ),
                  ),
                ),
                gapH8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        minimumSize: const Size(double.infinity, 60),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        await authService.signout();
                      },
                      child: Text(
                        "Sign Out",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 8,
                  height: 36,
                ),
              ],
            ),
          ),
        );
      },
      error: (err, stack) {
        return IconedFailure(
          message: err.toString(),
          displayIcon: const Icon(Icons.no_accounts),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: Colors.amber,
        ),
      ),
    );
  }
}
