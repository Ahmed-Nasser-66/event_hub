import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/auth/forgot_password.dart';
import 'package:event_hub/features/auth/login.dart';
import 'package:event_hub/features/auth/rest_password.dart';
import 'package:event_hub/features/auth/signup.dart';
import 'package:event_hub/features/auth/varification_otp.dart';
import 'package:event_hub/features/home/presentation/home_page.dart';
import 'package:event_hub/features/home/presentation/notification/notification_screen.dart';
import 'package:event_hub/features/onbording/onbording_screen.dart';
import 'package:event_hub/features/onbording/welcome_screen.dart';
import 'package:event_hub/features/profile/profile_tab.dart';
import 'package:event_hub/features/splash/splach_screen.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/providers/app_language_provider.dart';
import 'package:event_hub/providers/event_provider.dart';
import 'package:event_hub/providers/favorite_provider.dart';
import 'package:event_hub/providers/map_provider.dart';
import 'package:event_hub/providers/notification_provider.dart';
import 'package:event_hub/providers/ticket_provider.dart';
import 'package:event_hub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userProvider = UserProvider();
  await userProvider.loadUser();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (_) => userProvider),
        ChangeNotifierProvider(
            create: (_) => EventProvider()..refreshEvents()), // ✅ تعديل
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => TicketProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => MapProvider()..initializeMap()),
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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppLanguageProvider>().loadLanguage();
    });
  }

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
