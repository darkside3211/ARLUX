import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbb_app_v5/core/constants/app_colors.dart';
import 'package:jbb_app_v5/core/constants/app_sizes.dart';
import 'package:jbb_app_v5/features/auth/data/auth_service.dart';
import 'package:jbb_app_v5/features/auth/model/user_model.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';
import 'package:jbb_app_v5/presentation/widgets/input_fields.dart';

class AddressDialog extends ConsumerStatefulWidget {
  final Function(
    String addressLabel,
    String addressLine1,
    String addressLine2,
    String city,
    String state,
    String postalCode,
    String country,
  ) onSubmit;

  final String action;
  final AddressModel? addressModel;

  const AddressDialog({
    super.key,
    required this.action,
    required this.onSubmit,
    this.addressModel,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddressDialogState();
}

class _AddressDialogState extends ConsumerState<AddressDialog> {
  final _formKey = GlobalKey<FormState>();

  // Controllers to manage form inputs
  late TextEditingController _addressLabelController;
  late TextEditingController _addressLine1Controller;
  late TextEditingController _addressLine2Controller;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _postalCodeController;
  late TextEditingController _countryController;

  @override
  void initState() {
    super.initState();
    _addressLabelController =
        TextEditingController(text: widget.addressModel?.addressLabel);
    _addressLine1Controller =
        TextEditingController(text: widget.addressModel?.line1);
    _addressLine2Controller =
        TextEditingController(text: widget.addressModel?.line2);
    _cityController = TextEditingController(text: widget.addressModel?.city);
    _stateController = TextEditingController(text: widget.addressModel?.state);
    _postalCodeController =
        TextEditingController(text: widget.addressModel?.postal_code);
    _countryController =
        TextEditingController(text: widget.addressModel?.country ?? 'PH');
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    _addressLabelController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  // Function to handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(
        _addressLabelController.text,
        _addressLine1Controller.text,
        _addressLine2Controller.text,
        _cityController.text,
        _stateController.text,
        _postalCodeController.text,
        _countryController.text,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.amber)),
      backgroundColor: AppColors.black,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${widget.action} Address',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.amber),
          ),
          if (widget.addressModel != null && widget.action == 'Edit')
            TextButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                      child: CircularProgressIndicator(
                    color: Colors.amber,
                  )),
                );

                final isDone = await ref.read(deleteUserAddressProvider(
                        addressLabel: widget.addressModel!.addressLabel)
                    .future);

                if (context.mounted) {
                  Navigator.of(context, rootNavigator: true).pop();

                  if (isDone) {
                    Navigator.of(context).pop();
                    SnackBarFailure(context, message: "Successfully Deleted!");
                  } else {
                    SnackBarFailure(context, message: "Failed to delete.");
                  }
                }
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Address Label
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _addressLabelController,
                decoration: customInputDecoration(label: 'Label'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address label';
                  }
                  return null;
                },
              ),
              gapH4,

              // Address Line 1
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _addressLine1Controller,
                decoration: customInputDecoration(label: 'Complete Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address line 1';
                  }
                  return null;
                },
              ),
              gapH4,

              // Address Line 2
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _addressLine2Controller,
                decoration:
                    customInputDecoration(label: 'Address Line 2 (Optional)'),
              ),
              gapH4,

              // City
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _cityController,
                decoration: customInputDecoration(label: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the city';
                  }
                  return null;
                },
              ),
              gapH4,

              // State
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _stateController,
                decoration: customInputDecoration(label: 'State'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the state';
                  }
                  return null;
                },
              ),
              gapH4,
              // Postal Code
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _postalCodeController,
                decoration: customInputDecoration(label: 'Postal/Zip Code'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the postal code';
                  }
                  return null;
                },
              ),
              gapH4,

              // Country (default to PH)
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _countryController,
                decoration: customInputDecoration(label: 'Country'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () =>
              Navigator.of(context).pop(), // Cancel button to close dialog
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.yellow),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
          onPressed: () {
            _submitForm();
          },
          child: Text(
            "Confirm",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
