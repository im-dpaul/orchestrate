import 'package:orchestrate/core/constants/app_constants.dart';
import 'package:orchestrate/core/responsive/size_config.dart';
import 'package:orchestrate/core/routes/app_routes.dart';
import 'package:orchestrate/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:orchestrate/core/utils/shared_prefs.dart';
import 'package:orchestrate/features/authentication/controllers/login_provider.dart';
import 'package:orchestrate/features/authentication/controllers/signup_provider.dart';
import 'package:orchestrate/features/splash/controllers/splash_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefs.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                SizeConfig().init(constraints, orientation);
                SystemChrome.setSystemUIOverlayStyle(
                  const SystemUiOverlayStyle(
                    statusBarColor: AppColors.transparent,
                  ),
                );
                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider<SplashProvider>(
                      create: (_) => SplashProvider(),
                    ),
                    ChangeNotifierProvider<LoginProvider>(
                      create: (_) => LoginProvider(),
                    ),
                    ChangeNotifierProvider<SignupProvider>(
                      create: (_) => SignupProvider(),
                    ),
                  ],
                  child: MaterialApp(
                    initialRoute: '/',
                    title: Constants.appName,
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(fontFamily: 'SF-Pro-Rounded'),
                    onGenerateRoute: GenerateRoute.generateRoute,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
