import 'package:donor_app/core/di/injection_container.dart';
import 'package:donor_app/core/logic/language/language_cubit.dart';
import 'package:donor_app/core/logic/language/language_state.dart';
import 'package:donor_app/core/logic/theme/theme_cubit.dart';
import 'package:donor_app/core/logic/theme/theme_state.dart';
import 'package:donor_app/core/routing/app_router.dart';
import 'package:donor_app/core/themes/app_theme.dart';
import 'package:donor_app/core/widgets/internet_connection_listener.dart';
import 'package:donor_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:donor_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (_) => getIt<LanguageCubit>()..loadLanguage(),
        ),
        BlocProvider(create: (context) => getIt<ThemeCubit>()..loadTheme()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return BlocBuilder<LanguageCubit, LanguageState>(
                builder: (context, langState) {
                  return MaterialApp(
                    navigatorKey: navigatorKey,
                    theme: lightTheme(),
                    darkTheme: darkTheme(),
                    onGenerateRoute: appRouter.generateRoute,
                    supportedLocales: const [Locale('en'), Locale('ar')],
                    locale: langState.locale,
                    themeMode: themeState.themeMode,
                    themeAnimationDuration: Duration.zero,
                    themeAnimationCurve: Curves.linear,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    builder: (context, child) {
                      return InternetConnectionListener(
                        child: child ?? const SizedBox.shrink(),
                      );
                    },
                    debugShowCheckedModeBanner: false,
                    home: const SplashScreen(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
