import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stocks_app/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // User info section
          _buildUserInfo(context),

          const Divider(),

          // Language settings
          _buildSectionHeader(context, 'profile.language_settings'.tr()),
          _buildLanguageSelector(context),

          const Divider(),

          // Other profile settings
          _buildSectionHeader(context, 'profile.notification_settings'.tr()),
          _buildSwitchTile(context, 'profile.price_alerts'.tr(), true, (val) {
            /* handle switch */
          }),
          _buildSwitchTile(context, 'profile.news_updates'.tr(), false, (val) {
            /* handle switch */
          }),

          const Divider(),

          // About section
          _buildSectionHeader(context, 'profile.about'.tr()),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text('profile.version'.tr()),
            subtitle: const Text('1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.support_agent),
            title: Text('profile.contact_support'.tr()),
            onTap: () {
              // Contact support action
            },
          ),

          const Divider(),

          // Logout with confirmation
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: () async {
          try {
            // Show logout confirmation
            final shouldLogout = await _showLogoutConfirmationDialog(context);
            if (shouldLogout != true) return;

            // Show loading indicator
            if (context.mounted) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder:
                    (context) =>
                        const Center(child: CircularProgressIndicator()),
              );
            }

            // Sign out from Firebase
            await _auth.signOut();

            // Close the loading dialog if context is still valid
            if (context.mounted) {
              Navigator.of(context).pop();
            }

            // Force navigation to LoginScreen
            if (context.mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              );
            }
          } catch (e) {
            if (context.mounted) {
              Navigator.of(context).pop(); // Close loading dialog if open

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logout failed: ${e.toString()}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        child: Text(
          'profile.logout'.tr(),
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Future<bool?> _showLogoutConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'profile.logout_confirmation_title'.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text('profile.logout_confirmation_message'.tr()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('stock_detail.cancel'.tr()),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('profile.logout'.tr()),
              ),
            ],
          ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    final user = _auth.currentUser;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Show the image file from assets/images/profile.png
          CircleAvatar(
            radius: 50,
            backgroundImage: const AssetImage('assets/images/profile.png'),
          ),
          const SizedBox(height: 16),
          Text(
            user?.email ?? 'User',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    String getLanguageName(String code) {
      switch (code) {
        case 'en':
          return 'English';
        case 'hi':
          return 'हिन्दी (Hindi)';
        case 'ta':
          return 'தமிழ் (Tamil)';
        default:
          return 'English';
      }
    }

    return ListTile(
      leading: const Icon(Icons.language),
      title: Text('profile.select_language'.tr()),
      subtitle: Text(getLanguageName(context.locale.languageCode)),
      onTap: () {
        _showLanguagePickerDialog(context);
      },
    );
  }

  void _showLanguagePickerDialog(BuildContext context) {
    final supportedLanguages = [
      {'code': 'en', 'name': 'English'},
      {'code': 'hi', 'name': 'हिन्दी (Hindi)'},
      {'code': 'ta', 'name': 'தமிழ் (Tamil)'},
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('profile.select_language'.tr()),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children:
                  supportedLanguages.map((language) {
                    return ListTile(
                      title: Text(language['name']!),
                      trailing:
                          context.locale.languageCode == language['code']
                              ? const Icon(Icons.check, color: Colors.green)
                              : null,
                      onTap: () async {
                        // Change the app language
                        await context.setLocale(Locale(language['code']!));

                        // Save language preference
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString(
                          'language_code',
                          language['code']!,
                        );

                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                    );
                  }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('stock_detail.cancel'.tr()),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSwitchTile(
    BuildContext context,
    String title,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
