import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/auth/model/user_model.dart';
import 'package:jbb_app_v5/presentation/pages/user/address_dialog.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_icons.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_tiles.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:jbb_app_v5/presentation/widgets/input_fields.dart';

class EditUserPage extends ConsumerStatefulWidget {
  final UserModel userInfo;
  const EditUserPage({super.key, required this.userInfo});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditUserPageState();
}

class _EditUserPageState extends ConsumerState<EditUserPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _line1Controller = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  void _buildName() {
    if (widget.userInfo.username != null &&
        widget.userInfo.username!.isNotEmpty) {
      final String fullName = widget.userInfo.username!;

      List<String> username =
          fullName.split(',').map((name) => name.trim()).toList();

      _lastNameController.text = username[0];
      _firstNameController.text = username[1];
    }

    if (widget.userInfo.phone != null && widget.userInfo.phone!.isNotEmpty) {
      _phoneController.text = widget.userInfo.phone!;
    }
  }

  @override
  void initState() {
    _buildName();
    super.initState();
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _lastNameController.dispose();
    _firstNameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _line1Controller.dispose();
    _postalCodeController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  void _saveUserInfo() async {
    if (_formKey.currentState!.validate()) {
      final String username =
          "${_lastNameController.text}, ${_firstNameController.text}";

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
            child: CircularProgressIndicator(
          color: Colors.amber,
        )),
      );

      final isEdited = await ref.read(updateUserInfoProvider(
              username: username, phone: _phoneController.text)
          .future);

      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: true).pop();

      if (isEdited && context.mounted) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        SnackBarFailure(context, message: "Successfully updated!");
      } else {
        // ignore: use_build_context_synchronously
        SnackBarFailure(context, message: "Failed to update.");
      }
    }
  }

  Widget _buildAddress() {
    final address = ref.watch(getUserInfoProvider);

    return address.when(
      data: (item) {
        if (item.addresses.isNotEmpty) {
          final address = item.addresses;
          return Column(
            children: [
              Column(
                children: List.generate(address.length, (index) {
                  return AddressTile(addressModel: address[index]);
                }),
              )
            ],
          );
        } else {
          return const Center(
              child: Text(
            'Addresses are empty',
            style: TextStyle(
              color: Colors.amber,
            ),
          ));
        }
      },
      error: (err, stack) => IconedFailure(
        message: err.toString(),
        displayIcon: const Icon(Icons.error),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: Colors.amber,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff292929),
      appBar: AppBar(
        backgroundColor: const Color(0xff292929),
        foregroundColor: AppColors.yellow,
        title: Text(
          'Edit My Info',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.amber),
        ),
        actions: [
          TextButton.icon(
            icon: Text(
              'Save Changes',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            label: const Icon(
              Icons.check,
              size: 32,
              color: Colors.amber,
            ),
            onPressed: () {
              setState(() {
                _saveUserInfo();
              });
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(getUserInfoProvider.future),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const UserIcon(),
                gapH16,
                TextFormField(
                  controller: _firstNameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: customInputDecoration(label: 'First Name'),
                ),
                gapH8,
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _lastNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: customInputDecoration(label: 'Last Name'),
                ),
                gapH8,
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    // Simple validation for phone number format
                    if (value.startsWith(r'+639')) {
                      if (value.length == 13) {
                        return null;
                      }
                    } else if (value.startsWith(r'09')) {
                      if (value.length == 11) {
                        return null;
                      }
                    }

                    return 'Standard PH number should be 11-digits / 13-digits';
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: customInputDecoration(label: 'Phone Number'),
                ),
                const Divider(
                  thickness: 4,
                  height: 24,
                ),
                Text(
                  'Addresses',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.amber),
                ),
                _buildAddress(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.amber, width: 2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        minimumSize: const Size(double.infinity, 32),
                        elevation: 0,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) => AddressDialog(
                            action: 'Add New',
                            onSubmit: (addressLabel, addressLine1, addressLine2,
                                city, state, postalCode, country) async {
                              final isDone = await ref.read(
                                addUserAddressProvider(
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

                              if (context.mounted) {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();

                                if (isDone) {
                                  Navigator.of(context).pop();
                                  SnackBarFailure(context,
                                      message: "Successfully Added!");
                                } else {
                                  // ignore: use_build_context_synchronously
                                  SnackBarFailure(context,
                                      message: "Failed to Add.");
                                }
                              }
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Add New",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const Divider(),
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
                        setState(() {
                          _saveUserInfo();
                        });
                      },
                      child: Text(
                        "Save Changes",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
