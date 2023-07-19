import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:git_client_app/l10n/gm_localizations.dart';
import 'package:git_client_app/routes/home_page.dart';
import 'package:git_client_app/routes/login_page.dart';
import 'package:git_client_app/states/locale_model.dart';
import 'package:git_client_app/states/theme_model.dart';
import 'package:git_client_app/states/user_model.dart';
import 'package:provider/provider.dart';
import 'package:git_client_app/common/global.dart';

void main() {
  Global.init().then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => LocaleModel())
      ],
      child: Consumer2<ThemeModel, LocaleModel>(
          builder: ((context, themeModel, localeModel, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          onGenerateTitle: (context) => GmLocalization.of(context).title,
          locale: localeModel.getLocale(),
          supportedLocales: const [
            //只支持美式英语和中文简体
            Locale('en', 'US'),
            Locale('zh', 'CN')
          ],
          localizationsDelegates: [
            //本地化的代理类
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GmLocalizationsDelegate()
          ],
          localeResolutionCallback: (_locale, supportedLocles) {
            if (localeModel.getLocale() != null) {
              //如果已经选定语言，则不跟随系统
              return localeModel.getLocale();
            } else {
              //跟随系统
              Locale locale;
              if (supportedLocles.contains(_locale)) {
                locale = _locale!;
              } else {
                //如果系统语言不是中文简体或者美国英语，则默认使用美国英语
                locale = const Locale('en', 'US');
              }
              return locale;
            }
          },
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomeRoute(),
          routes: <String, WidgetBuilder>{
            'login': (context) => const LoginRoute()
          },
        );
      })),
    );
  }
}
