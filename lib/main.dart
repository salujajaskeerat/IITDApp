import 'package:IITDAPP/modules/attendance/data/attendanceProvider.dart';
import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/login/LoginScreen.dart';
import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:IITDAPP/modules/settings/data/SettingsData.dart';
import 'package:IITDAPP/modules/settings/data/SettingsHandler.dart';
import 'package:IITDAPP/routes/router.dart';
import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:IITDAPP/values/colors/colors.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await GlobalConfiguration().loadFromAsset('secrets');
    SyncfusionLicense.registerLicense(
        GlobalConfiguration().getString('calendar_api_key'));
  } catch (e) {
    print('secrets.json file is required');
  }

  unawaited(initialisePreferences());

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => NewsProvider<TrendingNews>(),
    ),
    ChangeNotifierProvider(
      create: (_) => NewsProvider<RecentNews>(),
    ),
    ChangeNotifierProvider(
      create: (_) => NewsProvider<OldNews>(),
    ),
    ChangeNotifierProvider(
      create: (_) => AttendanceProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => NewsHistoryProvider(),
    ),
    ChangeNotifierProvider<ThemeModel>(
      create: (_) => ThemeModel(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IITD APP',
      theme: Provider.of<ThemeModel>(context).themeType == ThemeType.Dark
          ? darkTheme
          : lightTheme,
      darkTheme: Provider.of<ThemeModel>(context).themeType == ThemeType.Light
          ? lightTheme
          : darkTheme,
//      ThemeData(
////        primarySwatch: Colors.indigo,
//        hintColor: Colors.white54,
////            scaffoldBackgroundColor: Colors.indigo[900],
////            canvasColor: Colors.indigo[700],
//        brightness: Brightness.light,
////            cardColor: Colors.indigo,
////            accentColor: Colors.lightBlueAccent
//      ),
      home: LoginScreen(),
      onGenerateRoute: Router.generateRoute,
    );
  }
}

// ignore: always_declare_return_types
initialisePreferences() async {
  var res = await SettingsHandler.getSettingValue(commonKeys[0]);
  defaultScreen = res;
}
