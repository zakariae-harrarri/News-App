import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
    listener: (BuildContext context,state){},
    builder: (BuildContext context,state){
      var list = NewsCubit.get(context).search;
          return Scaffold(
              appBar: AppBar(),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultFormField(
                      controler: searchControler,
                      label: "Search",
                      type: TextInputType.text,
                      prefix: Icons.search_outlined,
                      onChange: (value){
                        NewsCubit.get(context).getSearch(value.toString());
                      },
                      validate: (value){
                        if (value == null || value.isEmpty) {
                          return "you must enter search";
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: ConditionalBuilder(
                      condition: state is! NewsLoadingState,
                      builder: (context)=>ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index)=>itemNews(context: context,article:list[index]),
                        separatorBuilder: (context,index)=>separator(),
                        itemCount: list.length,
                      ),
                      fallback: (context)=>Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ],
              )
          );
        },
    );
  }
}
