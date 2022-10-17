import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:massa_app/pref/SharedControllerLag.dart';
import 'package:massa_app/provider/language_provider.dart';
import 'package:massa_app/test1.dart';
import 'package:massa_app/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

import 'Api/Images/images_screen.dart';
import 'Api/Images/upload_images.dart';
import 'Storage/shared_pref_controller.dart';
import 'TT.dart';
import 'UI/Auth/ForgotPassword.dart';
import 'UI/Auth/ResetPasswordScreen.dart';
import 'UI/Auth/SingUp.dart';
import 'UI/Auth/language.dart';
import 'UI/Auth/launch.dart';
import 'UI/Auth/login.dart';
import 'UI/PageView.dart';
import 'UI/Screens/BotoomNaviagtion/BottomNaviagtionScreen.dart';
import 'UI/Screens/BotoomNaviagtion/Home.dart';
import 'UI/Screens/BotoomNaviagtion/category.dart';
import 'UI/Screens/Settings.dart';
import 'UI/Screens/Sort/Date.dart';
import 'UI/Screens/Sort/OneShot.dart';
import 'UI/Screens/Sort/ScreenVideo.dart';
import 'UI/Screens/Sort/StoragePlace.dart';
import 'UI/Screens/Sort/gride_view.dart';
import 'UI/Screens/StartWithUs.dart';
import 'UI/Screens/editprofial.dart';
import 'UI/Screens/open_photo.dart';
import 'UI/Screens/profial.dart';
import 'UI/app_mode.dart';

// Display email in verifed screen
// in search screen add text to siecified the folder and the comment

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPreferrnces();
  await SharedControllerLag().initPref();
  runApp(MyApp()
      // ChangeNotifierProvider<ThemeNotifier>(
      //     create: (_) => new ThemeNotifier(), child: MyApp()),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider<String>(create: (context) => 'String'),
        ChangeNotifierProvider<LanguageProvider>(
            create: (context) => LanguageProvider()),
      ],
      child: MaterailApp(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ThemeNotifier>(
//       builder: (context, theme, _) {
//         return ScreenUtilInit(
//             designSize: const Size(414, 896),
//             minTextAdapt: true,
//             splitScreenMode: true,
//             builder: (context, child) {
//               return MaterialApp(
//                 theme: theme.getTheme(),
//                 // != null
//                 // ? theme.getTheme()
//                 // : theme.getTheme(),
//                 debugShowCheckedModeBanner: false,
//                 initialRoute: '/Launch',
//                 localizationsDelegates: const [
//                   GlobalWidgetsLocalizations.delegate,
//                   GlobalCupertinoLocalizations.delegate,
//                   GlobalMaterialLocalizations.delegate,
//                 ],
//                 supportedLocales: const [
//                   Locale('ar'),
//                   Locale('en'),
//                 ],
//                 locale: const Locale('en'),
//                 routes: {
//                   '/Launch': (context) => const Launch(),
//                   '/PageViewScreenMass': (context) =>
//                       const PageViewScreenMass(),
//                   '/Language': (context) => Language(),
//                   '/Login': (context) => Login(),
//                   '/ForgotPassword':(context)=>ForgotPassword(),
//                   '/ResetPasswordScreen': (context) =>
//                       const ResetPasswordScreen(
//                         email: '',
//                       ),
//                   '/SingUp': (context) => const SingUp(),
//                   '/BootomNaviagtionScreen': (context) =>
//                    BootomNaviagtionScreen(),
//                   '/Home': (context) => const Home(),
//                   '/Category': (context) => Category(), // note this line
//                   '/OneShot': (context) => const OneShot(),
//                   '/Date': (context) => const Date(),
//                   '/StoragePlace': (context) => const StoragePlace(),
//                   '/openphoto': (context) => const openphoto(),
//                   '/Profial': (context) => Profial(),
//                   '/AppMode': (context) => AppMode(),
//                   '/GrideView': (context) => const GrideView(),
//                   '/Settings': (context) => const Settings(),
//                   '/EditProfial': (context) => const EditProfial(),
//                   '/StartWithUs': (context) => const StartWithUs(),
//                   '/Test1': (context) => const Test1(),
//                   '/ScreenVideo': (context) => const ScreenVideo(),
//                   '/ImagesScreen': (context) => const ImagesScreen(),
//                   '/UploadImages': (context) => const UploadImages(),
//                   '/TT': (context) => TT(),
//                   '/startwithus': (context) => StartWithUs(),
//                 },
//               );
//             });
//       },
//     );
//   }
// }
class MaterailApp extends StatelessWidget {
  const MaterailApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeModeHandler(
        manager: ThemeManager(),
        builder: (ThemeMode themeMode) {
          return ScreenUtilInit(
              designSize: const Size(414, 896),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context,child){
                return MaterialApp(
                  themeMode: themeMode,
                  darkTheme: ThemeData(
                    brightness: Brightness.dark,
                  ),
                  theme: ThemeData(
                    brightness: Brightness.light,
                  ),
                  // != null
                  // ? theme.getTheme()
                  // : theme.getTheme(),
                  debugShowCheckedModeBanner: false,
                  // initialRoute: '/PageViewScreenMass',
                  // initialRoute: '/UploadImages',
                  initialRoute: '/Launch',
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('ar'),
                    Locale('en'),
                  ],
                  locale:
                      Locale(Provider.of<LanguageProvider>(context).language),
                  routes: {
                    '/Launch': (context) => const Launch(),
                    '/PageViewScreenMass': (context) =>
                        const PageViewScreenMass(), ////////
                    '/Language': (context) => Language(),
                    '/Login': (context) => Login(),
                    '/ForgotPassword': (context) => ForgotPassword(),
                    '/ResetPasswordScreen': (context) =>
                        const ResetPasswordScreen(email: '',),
                    '/SingUp': (context) => const SingUp(),
                    '/BootomNaviagtionScreen': (context) =>
                        BootomNaviagtionScreen(),
                    '/Home': (context) => const Home(),
                    '/Category': (context) => Category(), // note this line
                    '/OneShot': (context) => const OneShot(),
                    '/Date': (context) => const Date(),
                    '/StoragePlace': (context) => const StoragePlace(),
                    '/openphoto': (context) => const openphoto(), ////
                    '/Profial': (context) => Profial(),
                    '/AppMode': (context) => AppMode(),
                    '/GrideView': (context) => const GrideView(),
                    '/Settings': (context) => const Settings(),
                    '/EditProfial': (context) => const EditProfial(),
                    '/StartWithUs': (context) => const StartWithUs(),
                    '/Test1': (context) => const Test1(),
                    '/ScreenVideo': (context) => const ScreenVideo(), /////////
                    '/ImagesScreen': (context) => const ImagesScreen(), //////
                    '/UploadImages': (context) => const UploadImages(),
                    '/TT': (context) => TT(),
                    '/startwithus': (context) => StartWithUs(),
                  },
                );
              });
        });
  }
}

// from here
