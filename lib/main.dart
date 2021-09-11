import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rehnuma_mentor/Screens/Splashscreen/splashscreen.dart';
import 'package:rehnuma_mentor/models/user.dart';
import 'package:rehnuma_mentor/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        StreamProvider<MentorUser>.value(
          value: AuthService().user,
        ),
      ],
      child: MaterialApp(
        //localizationsDelegates: [
        //GlobalMaterialLocalizations.delegate,
        //GlobalWidgetsLocalizations.delegate,
        //DefaultCupertinoLocalizations.delegate,
        //GlobalCupertinoLocalizations
        //  .delegate,],
        locale: Locale('en', 'US'), // Current locale
        supportedLocales: [
          const Locale('en', 'US'), // English
          // Thai
        ],
        title: 'Rehnuma',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          primaryColor: Color(0xFF03A9AF),
          cursorColor: Color(0xFF03A9AF),
          appBarTheme: AppBarTheme(
              actionsIconTheme: IconThemeData(
            color: Colors.black,
          )),
          fontFamily: 'Poppins',
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
