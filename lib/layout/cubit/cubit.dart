import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/sciences/sciences_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';

import '../../shared/network/local/cache_helper.dart';
import '../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit():super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business_center_outlined),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: 'Sciences',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_soccer_outlined),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined),
      label: 'Settings',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SciencesScreen(),
    SportsScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index){
    currentIndex=index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> sciences = [];
  List<dynamic> sports = [];
  List<dynamic> search = [];

  void getBusiness(){
    emit(NewsLoadingState());
    DioHelpe.get(
      url: 'v2/top-headlines',
      query: {
        'country':'us',
        'category':'business',
        'apiKey':'9f372dc9ec2b4af19179411e4fc91596',
      },
    ).then((value){
      business=value.data['articles'];
      print(business[1]['title'].toString());
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }
  void getSciences(){
    emit(NewsLoadingState());
    DioHelpe.get(
      url: 'v2/top-headlines',
      query: {
        'country':'us',
        'category':'science',
        'apiKey':'9f372dc9ec2b4af19179411e4fc91596',
      },
    ).then((value){
      sciences=value.data['articles'];
      print(sciences[1]['title'].toString());
      emit(NewsGetSciencesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSciencesErrorState(error.toString()));
    });
  }
  void getSports(){
    emit(NewsLoadingState());
    DioHelpe.get(
      url: 'v2/top-headlines',
      query: {
        'country':'us',
        'category':'sports',
        'apiKey':'9f372dc9ec2b4af19179411e4fc91596',
      },
    ).then((value){
      sports=value.data['articles'];
      print(sports[1]['title'].toString());
      emit(NewsGetSportsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }
  void getSearch(String value){
    emit(NewsLoadingState());
    DioHelpe.get(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apiKey':'9f372dc9ec2b4af19179411e4fc91596',
      },
    ).then((value){
      search=value.data['articles'];
      print(search[1]['title'].toString());
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  bool isDark=false;

  void changeDarkMode({bool? mode}){
    if(mode!=null){
      isDark=mode;
      emit(NewsChangeDarkModeState());
    }
    else{
      isDark= !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeDarkModeState());
      });
    }
  }
}