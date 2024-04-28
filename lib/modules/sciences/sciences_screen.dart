import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';

import '../../shared/components/components.dart';

class SciencesScreen extends StatelessWidget {
  const SciencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list = NewsCubit.get(context).sciences;
        return ConditionalBuilder(
          condition: state is! NewsLoadingState,
          builder: (context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>itemNews(context: context,article:list[index]),
            separatorBuilder: (context,index)=>separator(),
            itemCount: list.length,
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
