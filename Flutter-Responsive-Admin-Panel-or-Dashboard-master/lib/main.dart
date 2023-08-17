import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/screens/dashboard/components/EditScreen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
        ],
        child: Builder(
          builder: (context) {
            final menuController = context.read<MenuAppController>();
            return Navigator(
              onGenerateRoute: (settings) {
                switch (settings.name) {
                  case '/':
                    return MaterialPageRoute(builder: (_) => MainScreen());
                  case '/edit':
                    return MaterialPageRoute(builder: (_) => EditScreen());
                  default:
                    return null;
                }
              },
              pages: [
                MaterialPage(child: MainScreen()),
                if (menuController.shouldNavigateToEditScreen)
                  MaterialPage(child: EditScreen()),
              ],
              onPopPage: (route, result) {
                if (!route.didPop(result)) {
                  return false;
                }
                menuController.setShouldNavigateToEditScreen(false);
                return true;
              },
            );
          },
        ),
      ),
    );
  }
}
