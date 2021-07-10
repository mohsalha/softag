import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softag/components/components.dart';
import 'package:softag/screens/main_screen/cubit/cubit.dart';
import 'package:softag/screens/main_screen/cubit/states.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MainCubit().get(context);
          if (cubit.categoryModel != null) {
            return Column(
              children: cubit.categoryModel!.data!.data!.map((e) {
                return categoryScreenItem(e);
              }).toList(),
            );
          } else {
            return SizedBox(
              height:MediaQuery.of(context).size.height/1.3,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }

}
