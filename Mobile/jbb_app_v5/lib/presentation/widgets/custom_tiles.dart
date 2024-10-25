import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/auth/model/user_model.dart';
import 'package:jbb_app_v5/presentation/pages/user/address_dialog.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';

abstract class CustomTiles {}



class AddressTile extends ConsumerWidget implements CustomTiles {
  final AddressModel addressModel;
  const AddressTile({super.key, required this.addressModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => AddressDialog(
              action: 'Edit',
              onSubmit: (addressLabel, addressLine1, addressLine2, city, state,
                  postalCode, country) async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                      child: CircularProgressIndicator(
                    color: Colors.amber,
                  )),
                );

                final isDone = await ref.read(
                  editUserAddressProvider(
                    addressLabel: addressModel.addressLabel,
                    address: AddressModel(
                      addressLabel: addressLabel,
                      line1: addressLine1,
                      line2: addressLine2,
                      city: city,
                      state: state,
                      postal_code: postalCode,
                    ),
                  ).future,
                );

                // ignore: use_build_context_synchronously
                Navigator.of(context, rootNavigator: true).pop();

                if (isDone && context.mounted) {
                  SnackBarFailure(context, message: "Successfully Modified!");
                } else {
                  // ignore: use_build_context_synchronously
                  SnackBarFailure(context, message: "Failed to modify.");
                }
              },
              addressModel: addressModel,
            ),
          );
        },
        child: ListTile(
          trailing: const Icon(Icons.edit),
          title: Text(
            addressModel.addressLabel,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${addressModel.line1} | ${addressModel.city}'),
              Text(
                  '${addressModel.state} | ${addressModel.country} : ${addressModel.postal_code}')
            ],
          ),
          dense: true,
          isThreeLine: true,
        ),
      ),
    );
  }
}
