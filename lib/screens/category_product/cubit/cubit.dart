
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softag/components/consts.dart';
import 'package:softag/controller/app_controller.dart';
import 'package:softag/dio/dio_helper.dart';
import 'package:softag/screens/category_product/cubit/satet.dart';

class CategoryProductCubit extends Cubit<CategoryProductState>{


  CategoryProductCubit() : super(CategoryProductInitState());

  CategoryProductCubit get(context) => BlocProvider.of(context);
  
  
  void getProducts (int id){
    
    emit(CategoryProductLoadingState());
    DioHelper.init();
    
    DioHelper.getData(url: CATEGORY_PRODUCT, token: AppController.instance.getToken(),query: {
      'category_id':id,
    }).then((value) {

      emit(CategoryProductSuccessState());
    }).catchError((e){
      print('categpry product error $e');
      emit(CategoryProductErrorState());
    });
    
  }
  
  
}