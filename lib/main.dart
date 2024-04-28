import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelpe.init();
  await CacheHelper.init();
  bool? modeDark = CacheHelper.getData(key: 'isDark');
  if(modeDark == null) modeDark=false;
  runApp(MyApp(modeDark!));
}

class MyApp extends StatelessWidget {
  final bool isMode;
  const MyApp(this.isMode);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>NewsCubit()..getBusiness()..getSciences()..getSports()..changeDarkMode(mode: isMode),
      child: BlocConsumer<NewsCubit,NewsStates>(
          listener: (BuildContext context,state){},
          builder: (BuildContext context,state){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              themeMode: NewsCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
              darkTheme: ThemeData(
                textTheme: TextTheme(
                  bodyText2: TextStyle(color: Colors.white),
                ),
                //
                scaffoldBackgroundColor: Colors.black87,
                appBarTheme: AppBarTheme(
                  color: Colors.black87,
                  foregroundColor: Colors.white,
                ),
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Colors.black87,
                  unselectedItemColor: Colors.white,
                  selectedItemColor: Colors.deepOrange.shade800,
                  type: BottomNavigationBarType.fixed,
                ),

                useMaterial3: true,
              ),
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  unselectedItemColor: Colors.grey.shade700,
                  selectedItemColor: Colors.blue.shade800,
                  type: BottomNavigationBarType.fixed,
                ),
                useMaterial3: true,
              ),
              home: NewLayout(),
            );
          },
        ),
    );
  }
}
