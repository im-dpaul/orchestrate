import 'package:flutter/material.dart';
import 'package:orchestrate/core/routes/app_routes.dart';
import 'package:orchestrate/core/services/firebase_auth_service.dart';
import 'package:orchestrate/core/themes/app_text_styles.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dashboard Screen',
                style: AppTextStyles.f26w600Black,
              ),
              IconButton(
                onPressed: () async {
                  await FirebaseAuthService().signOut();
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.loginScreen);
                  }
                },
                icon: const Icon(Icons.logout_outlined),
              )
            ],
          ),
        ),
      ),
    );
  }
}
