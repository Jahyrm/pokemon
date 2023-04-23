import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pokemon/apps/home/screens/home_screen.dart';
import 'package:pokemon/core/configs/global_vars.dart';
import 'package:pokemon/core/configs/themes.dart';
import 'package:pokemon/core/widgets/theme_switcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var brightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  bool isLightMode = brightness == Brightness.light;
  runApp(
    ThemeSwitcher(
      initialTheme: isLightMode ? AppThemes.light : AppThemes.dark,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: GlobalVars.appName,
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode:
          MyInheritedTheme.of(context).data?.brightness == Brightness.light
              ? ThemeMode.light
              : ThemeMode.dark,
      home: const HomeScreen(),
    );
  }
}
