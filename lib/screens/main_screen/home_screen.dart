import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:softag/components/components.dart';
import 'package:softag/components/consts.dart';
import 'package:softag/screens/main_screen/cubit/cubit.dart';
import 'package:softag/screens/main_screen/cubit/states.dart';
import 'package:softag/screens/main_screen/models/category.dart';
import 'package:softag/screens/main_screen/models/product.dart';
import 'package:softag/size_config.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(21)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.scaleHeight(15),
            ),
            desScreen(des: 'Delivering to'),
            SizedBox(
              height: SizeConfig.scaleHeight(5),
            ),
            Text(
              'Categories',
              style: TextStyle(
                fontSize: SizeConfig.scaleTextFont(24),
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: SizeConfig.scaleHeight(100),
                    child: BlocConsumer<MainCubit, MainState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        var cubit = MainCubit().get(context);

                        if (cubit.categoryModel != null) {
                          return SizedBox(
                            height: SizeConfig.scaleHeight(100),
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return categoryHomeItem(
                                    cubit.categoryModel!.data!.data![index]);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: SizeConfig.scaleWidth(20),
                                );
                              },
                              itemCount:
                                  cubit.categoryModel!.data!.data!.length,
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.scaleHeight(20),
                  ),
                  Text(
                    'Last Offers',
                    style: TextStyle(
                      fontSize: SizeConfig.scaleTextFont(22),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.scaleHeight(20),
                  ),
                  BlocConsumer<MainCubit, MainState>(
                    listener: (context, state) {
                      if (state is MainSuccessChangeFavoriteState) {
                        if (!state.changeFavoriteModel.status!) {
                          Fluttertoast.showToast(
                              msg: state.changeFavoriteModel.message!,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }
                    },
                    builder: (context, state) {
                      var cubit = MainCubit().get(context);
                      if (cubit.productModel != null) {
                        return Container(
                          color: Colors.grey[300],
                          child: GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisSpacing: SizeConfig.scaleWidth(1),
                            mainAxisSpacing: SizeConfig.scaleHeight(1),
                            childAspectRatio: SizeConfig.scaleWidth(1) /
                                SizeConfig.scaleHeight(1.9),
                            children:
                                cubit.productModel!.data!.products!.map((e) {
                              return productHomeItem(e, context);
                            }).toList(),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.scaleHeight(150)),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softag/components/components.dart';
import 'package:softag/controller/app_controller.dart';
import 'package:softag/screens/main_screen/cubit/cubit.dart';
import 'package:softag/screens/main_screen/cubit/states.dart';
import 'package:softag/size_config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MainCubit().get(context);
        return SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(21)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.scaleHeight(15),
                ),
                desScreen(des: 'Delivering to'),
                SizedBox(
                  height: SizeConfig.scaleHeight(5),
                ),
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: SizeConfig.scaleTextFont(24),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                  SizedBox(
                  height: SizeConfig.scaleHeight(150),
                  child: ListView.separated(
                    shrinkWrap: true  ,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,

                    itemBuilder: (context, index) {
                      return Image.network(cubit.categoryModel!.data!.data![index].image!);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: SizeConfig.scaleWidth(15),
                      );
                    },
                    itemCount: cubit.categoryModel!.data!.data!.length,
                  ),
                ) ,
              ],
            ),
          ),
        );
      },
    );
  }
}






 */
