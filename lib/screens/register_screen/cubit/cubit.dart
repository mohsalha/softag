import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:softag/components/consts.dart';
import 'package:softag/dio/dio_helper.dart';
import 'package:softag/screens/login_screen/models.dart';
import 'package:softag/screens/register_screen/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool visibility = true;

  bool visibilityConfirm = true;

  UserModel userModel = UserModel();

  void changeVisibility() {
    visibility = !visibility;
    emit(RegisterChangeState());
  }

  void changeVisibilityConfirm() {
    visibilityConfirm = !visibilityConfirm;
    emit(RegisterChangeConfirmState());
  }

  void register({
    required String password,
    required String confirmPassword,
    required String name,
    required String phone,
    required String email,
  }) {
    DioHelper.init();
    emit(RegisterLoadingState());

    if(password == confirmPassword){
      DioHelper.postData(url: REGISTER, data: {
        'name':name,
        'phone':phone,
        'email':email,
        'password':password,
      }).then((value) {

        userModel = UserModel.fromJson(value.data);
        emit(RegisterSuccessState());

      }).catchError((e){
        print('register error $e');
        emit(RegisterErrorState());
      });
      return;
    }else{
      Fluttertoast.showToast(
        msg: 'Verify the password',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: defaultColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      emit(RegisterVerifyPasswordState());

    }

    
    
  }
}
