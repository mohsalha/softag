import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softag/components/components.dart';
import 'package:softag/screens/main_screen/cubit/cubit.dart';
import 'package:softag/screens/main_screen/cubit/states.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainState>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = MainCubit().get(context);
        if(state is MainErrorGetFavoriteState){
          return Center(child: CircularProgressIndicator());
        }else if(state is MainLoadingGetFavoriteState){
          print(state.runtimeType.toString());
          return Center(child: CircularProgressIndicator());
        }else{
          return ListView.separated(physics: BouncingScrollPhysics(),itemBuilder:(context,index){
            return  favoriteItem(cubit.favoriteModel!.data!.data![index],context);
          }, separatorBuilder: (context,index){
            return Divider();
          }, itemCount: cubit.favoriteModel!.data!.data!.length);
        }      },
    );
  }

}


/*
if(state is MainErrorGetFavoriteState){
          return Center(child: CircularProgressIndicator());
        }else if(state is MainLoadingGetFavoriteState){
          print(state.runtimeType.toString());
          return Center(child: CircularProgressIndicator());
        }else{
          return ListView.separated(physics: BouncingScrollPhysics(),itemBuilder:(context,index){
            return  favoriteItem(cubit.favoriteModel!.data!.data![index],context);
          }, separatorBuilder: (context,index){
            return Divider();
          }, itemCount: cubit.favoriteModel!.data!.data!.length);
        }
 */