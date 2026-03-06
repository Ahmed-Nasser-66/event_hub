import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/auth/forgot_password.dart';
import 'package:event_hub/features/auth/login.dart';
import 'package:event_hub/features/auth/rest_password.dart';
import 'package:event_hub/features/auth/signup.dart';
import 'package:event_hub/features/auth/varification_otp.dart';
import 'package:event_hub/features/home/presentation/home_page.dart';
import 'package:event_hub/features/home/presentation/tabs/notification_screen.dart';
import 'package:event_hub/features/home/presentation/tabs/profile_tab.dart';
import 'package:event_hub/features/onbording/onbording_screen.dart';
import 'package:event_hub/features/onbording/welcome_screen.dart';
import 'package:event_hub/features/splash/splach_screen.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/providers/app_language_provider.dart';
import 'package:event_hub/providers/event_provider.dart';
import 'package:event_hub/providers/favorite_provider.dart';
import 'package:event_hub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var languageprovider = Provider.of<AppLanguageProvider>(context);
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.grey,
          titleTextStyle: TextStyle(
            color: AppColors.orange,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: AppColors.orange),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        "login": (context) => Login(),
        "signup": (context) => Signup(),
        "homepage": (context) => Homepage(),
        "onboarding": (context) => OnBoarding(),
        "welcome": (context) => WelcomeScreen(),
        "forgotpassword": (context) => Forgotpassword(),
        "varification": (context) => VarificationOtp(),
        "restpassword": (context) => RestPassword(),
        "profile": (context) => ProfileTab(),
        "notifications": (context) => NotificationScreen(),
      },
      locale: Locale(languageprovider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
