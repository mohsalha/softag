import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softag/components/consts.dart';
import 'package:softag/screens/main_screen/cubit/cubit.dart';
import 'package:softag/screens/main_screen/cubit/states.dart';
import 'package:softag/screens/main_screen/models/category.dart';
import 'package:softag/size_config.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MainCubit().get(context);
          if (cubit.categoryModel!.data != null) {
            return Column(
              children: cubit.categoryModel!.data!.data!.map((e) {
                return categoryScrerenItem(e);
              }).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget categoryScrerenItem(CategoryData categoryData) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.scaleWidth(10),
          vertical: SizeConfig.scaleHeight(15)
        ),
        child: ListTile(
          onTap: (){},
          title: Text(
            '${categoryData.name}',
            style: TextStyle(
              fontSize: SizeConfig.scaleTextFont(16),
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: SizedBox(
            height: SizeConfig.scaleHeight(200),
            width: SizeConfig.scaleWidth(80),
            child: Image.network(
              '${categoryData.image}',
              height: SizeConfig.scaleHeight(200),
              width: SizeConfig.scaleWidth(80),
              fit: BoxFit.contain,

              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: SizeConfig.scaleHeight(14),
          ),
        ),
      );
}
