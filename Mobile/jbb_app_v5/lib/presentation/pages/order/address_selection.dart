import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/auth/model/user_model.dart';
import 'package:jbb_app_v5/presentation/providers/state_providers.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';

class AddressSelection extends ConsumerWidget {
  const AddressSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(getUserInfoProvider);
    final address = ref.watch(defaultAddressProvider);

    Widget buildAddress() {
      return user.when(
        data: (data) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.addresses.length,
            itemBuilder: (context, index) {
              final addressItem = data.addresses[index];
              final isSelected = address == addressItem;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: AddressExpansionTile(
                  address: data.addresses[index],
                  onSelect: () {
                    ref.read(defaultAddressProvider.notifier).state =
                        data.addresses[index];

                    Navigator.of(context).pop();
                  },
                  isDefault: isSelected,
                ),
              );
            },
          );
        },
        error: (err, stack) {
          return const IconedFailure(
            message: 'Failed to load addresses',
            displayIcon: Icon(Icons.error),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        ),
      );
    }

    return Drawer(
        child: ListView(
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xff292929),
          ),
          child: Text(
            'Select Address',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        buildAddress(),
      ],
    ));
  }
}

class AddressExpansionTile extends StatelessWidget {
  final bool isDefault;
  final AddressModel address;
  final VoidCallback onSelect;

  const AddressExpansionTile({
    super.key,
    required this.address,
    required this.onSelect,
    required this.isDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.shade50,
      child: ExpansionTile(
        initiallyExpanded: isDefault,
        expandedAlignment: Alignment.topLeft,
        leading: isDefault
            ? const Icon(
                Icons.check_box,
                color: Colors.amber,
              )
            : const Icon(
                Icons.check_box_outline_blank,
                color: AppColors.black,
              ),
        title: Text(address.addressLabel, style: const TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text(
          address.line1,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Line1: ${address.line1}'),
                Text('Line2: ${address.line2}'),
                Text('City: ${address.city}'),
                Text('State: ${address.state}'),
                Text('Country: ${address.country}'),
                Text('Postal Code: ${address.postal_code}'),
                const SizedBox(height: 8),
                if (!isDefault)
                  ElevatedButton(
                    onPressed: onSelect,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellow,
                        foregroundColor: const Color(0xff292929)),
                    child: const Text('Select'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
