import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bindings/initial_binding.dart';
import 'routes/app_pages.dart';

void main() async {
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = (GetStorage().read('isDark') ?? false);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        textTheme: GoogleFonts.poppinsTextTheme(),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        textTheme: GoogleFonts.poppinsTextTheme(),
        brightness: Brightness.dark,
      ),
      defaultTransition: Transition.cupertino,
      initialRoute: Routes.home,
      initialBinding: InitialBinding(),
      getPages: AppPages.pages,
    );
  }
}
