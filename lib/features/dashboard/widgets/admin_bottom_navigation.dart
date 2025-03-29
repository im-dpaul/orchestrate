import 'package:flutter/material.dart';
import 'package:orchestrate/core/constants/strings.dart';
import 'package:orchestrate/core/responsive/size_extension.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:orchestrate/widgets/buttons/menu_icon_button.dart';

class AdminBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onTabChange;

  const AdminBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.h,
      decoration: const BoxDecoration(
        color: AppColors.pureWhite,
        boxShadow: [
          BoxShadow(color: AppColors.softGray, spreadRadius: 2, blurRadius: 8)
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MenuIconButton(
            title: Strings.home,
            isSelected: selectedIndex == 0,
            icon: selectedIndex == 0 ? Icons.home_sharp : Icons.home_outlined,
            onTap: () {
              onTabChange(0);
            },
          ),
          MenuIconButton(
            title: Strings.events,
            isSelected: selectedIndex == 1,
            icon: selectedIndex == 1
                ? Icons.event_available_sharp
                : Icons.event_available_outlined,
            onTap: () {
              onTabChange(1);
            },
          ),
          MenuIconButton(
            title: Strings.settings,
            isSelected: selectedIndex == 2,
            icon: selectedIndex == 2
                ? Icons.settings_sharp
                : Icons.settings_outlined,
            onTap: () {
              onTabChange(2);
            },
          ),
        ],
      ),
    );
  }
}
