import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softag/components/consts.dart';
import 'package:softag/controller/app_controller.dart';
import 'package:softag/dio/dio_helper.dart';
import 'package:softag/screens/login_screen/models.dart';
import 'package:softag/screens/main_screen/cubit/states.dart';
import 'package:softag/screens/main_screen/models/category.dart';
import 'package:softag/screens/main_screen/models/change_favorite_model.dart';
import 'package:softag/screens/main_screen/models/favorite_model.dart';
import 'package:softag/screens/main_screen/models/product.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitState());

  MainCubit get(context) => BlocProvider.of(context);

  int index = 0;
  CategoryModel? categoryModel;

  UserModel? userModel;

  UserData? userData;

  ProductModel? productModel;

  Map<int, bool> favorite = {};

  ChangeFavoriteModel? changeFavoriteModel;

  FavoriteModel? favoriteModel;

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
      }
      emit(MainSuccessCategoryState());
    }).catchError((e) {
      emit(MainErrorCategoryState());
    });
  }

  void getProduct() {
    emit(MainLoadingProductState());
    DioHelper.init();

    DioHelper.getData(
      url: HOME_PRODUCT,
      token: AppController.instance.getToken(),
    ).then((value) {
      if (value.data != null) {
        productModel = ProductModel.fromJson(value.data);
        productModel!.data!.products!.forEach((element) {
          favorite.addAll({element.id!: element.inFavorites!});
        });
      }
      emit(MainSuccessProductState());
    }).catchError((e) {
      emit(MainErrorProductState());
    });
  }

  void getUserData() {
    emit(MainLoadingDataState());
    DioHelper.init();
    print('token : ${AppController.instance.getToken()}');

    DioHelper.getData(url: PROFILE, token: AppController.instance.getToken())
        .then((value) {
      print(value.data.toString());
      userModel = UserModel.fromJson(value.data);

      userData = userModel!.data;
      emit(MainSuccessDataState());
    }).catchError((e) {
      emit(MainErrorDataState());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(MainLoadingUpdateState());
    DioHelper.init();
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: AppController.instance.getToken(),
      data: {
        'email': email,
        'phone': phone,
        'name': name,
      },
    ).then((value) {
      print(value.data.toString());
      userModel = UserModel.fromJson(value.data);
      userData = userModel!.data;
      emit(MainSuccessUpdateState());
    }).catchError((e) {
      emit(MainErrorUpdateState());
    });
  }

  void changeFavorite(int id) {
    if (favorite[id] == true) {
      favorite[id] = false;
      emit(MainChangeFavoriteState());
    } else {
      favorite[id] = true;
      emit(MainChangeFavoriteState());
    }

    DioHelper.init();
    DioHelper.postData(
      url: FAVORITE,
      data: {
        'product_id': id,
      },
      token: AppController.instance.getToken(),
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.formJson(value.data);
      if (!changeFavoriteModel!.status!) {
        if (favorite[id] == true) {
          favorite[id] = false;
        } else {
          favorite[id] = true;
        }
      } else {
        getFavorite();
      }
      emit(MainSuccessChangeFavoriteState(changeFavoriteModel!));
    }).catchError((e) {
      if (favorite[id] == true) {
        favorite[id] = false;
      } else {
        favorite[id] = true;
      }
      emit(MainErrorChangeFavoriteState());
    });
  }

  void getFavorite() {
    emit(MainLoadingGetFavoriteState());

    DioHelper.init();

    DioHelper.getData(
      url: FAVORITE,
      token: AppController.instance.getToken(),
    ).then((value) {
      if (value.data != null) {
        favoriteModel = FavoriteModel.fromJson(value.data);
      }
      emit(MainSuccessGetFavoriteState());
    }).catchError((e) {
      emit(MainErrorGetFavoriteState());
    });
  }
}
