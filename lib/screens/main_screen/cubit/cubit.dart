import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softag/components/consts.dart';
import 'package:softag/controller/app_controller.dart';
import 'package:softag/dio/dio_helper.dart';
import 'package:softag/screens/main_screen/cubit/states.dart';
import 'package:softag/screens/main_screen/models/category.dart';
import 'package:softag/screens/main_screen/models/product.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitState());

  MainCubit get(context) => BlocProvider.of(context);

  int index = 0;
  CategoryModel? categoryModel;

  ProductModel? productModel;
  
  
  void changeScreen(int index) {
    this.index = index;
    emit(MainChangeState());
  }

  void getCategory() {
    emit(MainLoadingCategoryState());
    DioHelper.init();
    DioHelper.getData(url: CATEGORY).then((value) {
      if (value.data != null) {
        categoryModel = CategoryModel.fromJson(value.data);
        print('value data is ${categoryModel!.data!.data![0].name}');
        print("token : ${AppController.instance.getToken()}");
      }
      emit(MainSuccessCategoryState());
    }).catchError((e) {
      print('error category $e');
      emit(MainErrorCategoryState());
    });
  }

  void getProduct() {
    emit(MainLoadingProductState());
    DioHelper.init();
    
    DioHelper.getData(url: HOME_PRODUCT,token: AppController.instance.getToken(),).then((value) {
      if (value.data != null) {
        productModel = ProductModel.fromJson(value.data);
        print('value data is ${productModel!.data!.products![0].name}');
      }
      emit(MainSuccessProductState());
    }).catchError((e){
      print('error home product $e');
      emit(MainErrorProductState());
    });
    
  }
}
