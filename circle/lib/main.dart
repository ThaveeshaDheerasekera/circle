import 'package:circle/configs/custom_colors.dart';
import 'package:circle/firebase_options.dart';
import 'package:circle/models/entries_model.dart';
import 'package:circle/repositories/auth_repository.dart';
import 'package:circle/repositories/notes_repository.dart';
import 'package:circle/screens/login_screen.dart';
import 'package:circle/widget/global_widgets/bottom_nav_bar_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EntriesModel()),
        ChangeNotifierProvider(create: (context) => AuthRepository()),
        ChangeNotifierProvider(create: (context) => NotesRepository()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Circle',
        theme: ThemeData(
          fontFamily: 'Karla',
          colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.olive),
          useMaterial3: true,
          buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 22,
              fontFamily: 'Karla',
              fontWeight: FontWeight.w700,
            ),
            headlineMedium: TextStyle(
              fontSize: 20,
              fontFamily: 'Karla',
              fontWeight: FontWeight.w700,
            ),
            headlineSmall: TextStyle(
              fontSize: 18,
              fontFamily: 'Karla',
              fontWeight: FontWeight.w600,
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              fontFamily: 'Karla',
              fontWeight: FontWeight.w500,
            ),
            // Define font style for regular text
            bodyMedium: TextStyle(
              fontSize: 14,
              fontFamily: 'Karla',
              fontWeight: FontWeight.w500,
            ),
            bodySmall: TextStyle(
              fontSize: 12,
              fontFamily: 'Karla',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        home: StreamBuilder(
          stream: AuthRepository().authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Provider.of<AuthRepository>(context, listen: false)
                  .clearMessage();
              return BottomNavBarWidget();
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
