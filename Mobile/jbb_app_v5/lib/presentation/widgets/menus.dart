import 'package:flutter/material.dart';
import 'package:jbb_app_v5/core/network/network_core.dart';
import 'package:jbb_app_v5/presentation/widgets/custom_buttons.dart';
import 'package:jbb_app_v5/presentation/widgets/failure_widget.dart';

abstract class Menus {}

class HomeMenuDrawer extends StatelessWidget {
  const HomeMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff292929),
            ),
            child: Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Host Address'),
            onTap: () {
              Navigator.of(context).pop();
              _showHostAddressDialog(context);
            },
          ),
          const ThemeToggleButton(),
        ],
      ),
    );
  }

  void _showHostAddressDialog(BuildContext context) {
    final TextEditingController ipController = TextEditingController();
    final TextEditingController portController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Set Host Address',
            style: TextStyle(color: Colors.black),
          ),
          content: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: ipController,
                  decoration: const InputDecoration(
                    hintText: 'IP Address',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: portController,
                  decoration: const InputDecoration(
                    hintText: 'Port',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.amber),
              ),
              onPressed: () {
                String ipAddress = ipController.text.trim();
                String portAddress = portController.text.trim();

                if (ipAddress.isEmpty || portAddress.isEmpty) {
                  SnackBarFailure(context,
                      message: 'Please enter both IP and Port');
                  return;
                }

                try {
                  int parsedPort = int.parse(portAddress);
                  if (parsedPort <= 0 || parsedPort > 65535) {
                    SnackBarFailure(context,
                        message:
                            'Invalid port number. Must be between 1 and 65535');
                    return;
                  }
                } catch (e) {
                  SnackBarFailure(context,
                      message: 'Invalid port number. Must be a number');
                  return;
                }

                HostAddress.setValue(newIp: ipAddress, newPort: portAddress);
                Navigator.of(context).pop();
                SnackBarFailure(context,
                    message: 'Host address updated successfully');
              },
            ),
          ],
        );
      },
    );
  }
}
