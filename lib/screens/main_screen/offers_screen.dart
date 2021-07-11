import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softag/components/components.dart';
import 'package:softag/screens/main_screen/cubit/cubit.dart';
import 'package:softag/screens/main_screen/cubit/states.dart';
import 'package:softag/size_config.dart';


class OffersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cubit = MainCubit().get(context);
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding:  EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(20)),
          child: cubit.productModel != null ?SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:  GridView.count(
              crossAxisCount: 1,
              childAspectRatio: SizeConfig.scaleWidth(1)/SizeConfig.scaleHeight(.9),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children:cubit.productModel!.data!.products!.map((e) {
                return productItemScreen(e);
              }).toList(),
            ),
          ):Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }

}
