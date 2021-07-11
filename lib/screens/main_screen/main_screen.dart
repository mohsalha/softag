import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softag/components/components.dart';
import 'package:softag/components/consts.dart';
import 'package:softag/controller/app_controller.dart';
import 'package:softag/screens/main_screen/cubit/cubit.dart';
import 'package:softag/screens/main_screen/cubit/states.dart';
import 'package:softag/screens/main_screen/home_screen.dart';
import 'package:softag/screens/main_screen/category_screen.dart';
import 'package:softag/screens/main_screen/setting_screen.dart';
import 'package:softag/screens/main_screen/offers_screen.dart';
import 'package:softag/screens/main_screen/favorite_screen.dart';
import 'package:softag/size_config.dart';

class MainScreen extends StatelessWidget {
  PageController _pageController = PageController();
  List<String> _title = [
    'Good morning ',
    'Category',
    'Latest Offers',
    'Favorite',
    'Setting',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()
        ..getUserData()
        ..getFavorite()
        ..getCategory()
        ..getProduct(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MainCubit().get(context);

if(cubit.userModel != null){
  return Scaffold(
    appBar: AppBar(
      centerTitle: false,
      title: Text(
        '${_title[cubit.index]}${cubit.index == 0 ? cubit.userModel!.data!.name??'' : ''}!',
        style: TextStyle(
          color: Colors.black,
          fontSize: SizeConfig.scaleTextFont(16),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.scaleWidth(21)),
          child: Icon(
            Icons.add_shopping_cart,
            color: Colors.black,
          ),
        )
      ],
    ),
    floatingActionButtonLocation:
    FloatingActionButtonLocation.centerDocked,
    bottomNavigationBar: BottomAppBar(
      elevation: 45,
      notchMargin: 10,
      shape: CircularNotchedRectangle(),
      child: Container(
        height: SizeConfig.scaleHeight(92),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.scaleWidth(15)),
          child: Row(
            children: [
              bottomBarItem(
                title: 'Category',
                icon: Icons.grid_view,
                index: 1,
                currentIndex: cubit.index,
                pageController: _pageController,
              ),
              SizedBox(
                width: SizeConfig.scaleWidth(44),
              ),
              bottomBarItem(
                title: 'Offers',
                icon: Icons.shopping_bag_sharp,
                index: 2,
                currentIndex: cubit.index,
                pageController: _pageController,
              ),
              Spacer(),
              bottomBarItem(
                title: 'Favorite',
                icon: Icons.favorite_border,
                index: 3,
                currentIndex: cubit.index,
                pageController: _pageController,
              ),
              SizedBox(
                width: SizeConfig.scaleWidth(44),
              ),
              bottomBarItem(
                title: 'Setting',
                icon: Icons.settings,
                index: 4,
                currentIndex: cubit.index,
                pageController: _pageController,
              ),
            ],
          ),
        ),
      ),
    ),
    body: PageView(
      controller: _pageController,
      onPageChanged: (index) {
        print('Page Changes to index $index');
        cubit.changeScreen(index);
      },
      children: [
        HomeScreen(),
        CategoryScreen(),
        OffersScreen(),
        ProfileScreen(),
        MoreScreen(),
      ],
      physics: NeverScrollableScrollPhysics(),
    ),
    floatingActionButton: SizedBox(
      height: SizeConfig.scaleHeight(65),
      width: SizeConfig.scaleWidth(65),
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: cubit.index == 0 ? defaultColor : greyColor,
          onPressed: () {
            _pageController.jumpToPage(0);
            cubit.index = 0;
          },
          child: Icon(
            Icons.home,
            color: Colors.white,
            size: SizeConfig.scaleHeight(30),
          ),
          // elevation: 5.0,
        ),
      ),
    ),
  );
}else{
  return Scaffold(body: Center(child: CircularProgressIndicator()));
}

        },
      ),
    );
  }
}
