import 'package:admin_app_ecommerce/main_layout/cubit/main_layout_cubit.dart';
import 'package:admin_app_ecommerce/screens/login_register/phone_screen/cubit/phone_cubit.dart';
import 'package:admin_app_ecommerce/screens/login_register/sign_in/cubit/sign_in_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:admin_app_ecommerce/screens/splash_screen/splash_screen.dart';
import 'package:admin_app_ecommerce/shared/cubit/bloc_observer.dart';
import 'package:admin_app_ecommerce/shared/services/local/cache_helper.dart';
import 'package:admin_app_ecommerce/shared/services/network/dio_helper.dart';
import 'package:admin_app_ecommerce/shared/styles/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await CachedHelper.init();
      await Firebase.initializeApp();
      DioHelper.init();
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext) => PhoneCubit()),
        BlocProvider(create: (BuildContext) => MainLayoutCubit()),
        BlocProvider(create: (BuildContext) => SignInCubit()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home:SplashScreen(),
      ),
    );
  }

}
