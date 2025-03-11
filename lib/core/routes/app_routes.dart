import 'package:flutter/material.dart';
import 'package:orchestrate/features/authentication/views/create_reset_password_screen.dart';
import 'package:orchestrate/features/authentication/views/forgot_password_screen.dart';
import 'package:orchestrate/features/authentication/views/login_screen.dart';
import 'package:orchestrate/features/authentication/views/otp_screen.dart';
import 'package:orchestrate/features/authentication/views/role_selection_screen.dart';
import 'package:orchestrate/features/authentication/views/signup_screen.dart';
import 'package:orchestrate/features/dashboard/views/dashboard_screen.dart';
import 'package:orchestrate/features/home/views/home_screen.dart';
import 'package:orchestrate/features/splash/views/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splashScreen';

  static const String loginScreen = '/loginScreen';
  static const String signupScreen = '/signupScreen';
  static const String roleSelectionScreen = '/roleSelectionScreen';
  static const String otpScreen = '/otpScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String createResetPasswordScreen = '/createResetPasswordScreen';

  static const String homeScreen = '/homeScreen';

  static const String dashboardScreen = '/dashboardScreen';
}

mixin GenerateRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String? route = settings.name;
    // final arguments = settings.arguments;

    switch (route) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );

      case '/loginScreen':
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          settings: settings,
        );

      case '/signupScreen':
        return MaterialPageRoute(
          builder: (context) => const SignupScreen(),
          settings: settings,
        );

      case '/roleSelectionScreen':
        return MaterialPageRoute(
          builder: (context) => const RoleSelectionScreen(),
          settings: settings,
        );

      case '/otpScreen':
        return MaterialPageRoute(
          builder: (context) => const OTPScreen(),
          settings: settings,
        );

      case '/forgotPasswordScreen':
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
          settings: settings,
        );

      case '/createResetPasswordScreen':
        return MaterialPageRoute(
          builder: (context) => const CreateResetPasswordScreen(),
          settings: settings,
        );

      case '/homeScreen':
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
          settings: settings,
        );

      case '/dashboardScreen':
        return MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
    }
  }
}
