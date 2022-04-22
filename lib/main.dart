import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/bloc_observer.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';
import 'package:todo_app/shared/styles/themes.dart';
import 'layout/todo_app/todo_layout.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  bool? isDark=CacheHelper.getData(key: 'isDark');

  BlocOverrides.runZoned(
          ()=>runApp(MyApp(
        isDark: isDark,
      )),
      blocObserver: MyBlocObserver()
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;
  MyApp({this.isDark,this.startWidget});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AppCubit()..changeAppMode(fromShared:isDark),

      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            darkTheme: darkMode,
            themeMode: AppCubit.get(context).isDark?ThemeMode.light:ThemeMode.light,
            home: HomeLayout(),
          );
        },

      ),
    );
  }
}
