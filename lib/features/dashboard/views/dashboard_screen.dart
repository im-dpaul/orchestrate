import 'package:flutter/material.dart';
import 'package:orchestrate/core/routes/app_routes.dart';
import 'package:orchestrate/core/services/firebase_auth_service.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:orchestrate/core/themes/app_text_styles.dart';
import 'package:orchestrate/features/dashboard/controllers/admin_dashboard_provider.dart';
import 'package:orchestrate/features/dashboard/widgets/admin_bottom_navigation.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminDashboardProvider dashboardProvider =
        Provider.of<AdminDashboardProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: SafeArea(
        child: Center(
          child: PageView(
            controller: dashboardProvider.pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int index) {
              dashboardProvider.updateTabIndex(index);
            },
            children: [
              Text(
                'Dashboard Screen',
                style: AppTextStyles.f26w600Black,
              ),
              Text(
                'Event Screen',
                style: AppTextStyles.f26w600Black,
              ),
              Column(
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Consumer<AdminDashboardProvider>(
        builder: (BuildContext context, AdminDashboardProvider provider, _) =>
            AdminBottomNavigation(
          selectedIndex: provider.selectedIndex,
          onTabChange: (int index) {
            dashboardProvider.updateTabIndex(index);
          },
        ),
      ),
    );
  }
}
