import 'package:flutter/material.dart';
import 'package:orchestrate/core/responsive/size_extension.dart';
import 'package:orchestrate/widgets/buttons/app_back_button.dart';

class CommonAppBar extends StatelessWidget {
  final void Function() onBackButtonTap;

  const CommonAppBar({
    super.key,
    required this.onBackButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppBackButton(
            onButtonTap: onBackButtonTap,
          )
        ],
      ),
    );
  }
}
