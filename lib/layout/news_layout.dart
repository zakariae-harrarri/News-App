import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import '../shared/components/components.dart';

class NewLayout extends StatelessWidget {
  const NewLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context,state){},
      builder: (BuildContext context,state){
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: (){
                  navTO(context,SearchScreen());
                },
                icon: Icon(Icons.search,),
                iconSize: 30,
              ),
              IconButton(
                onPressed: (){
                  NewsCubit.get(context).changeDarkMode();
                },
                icon: Icon(Icons.brightness_4_outlined,),
                iconSize: 30,
              )
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
