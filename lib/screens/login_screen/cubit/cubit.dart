import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softag/components/consts.dart';
import 'package:softag/dio/dio_helper.dart';
import 'package:softag/screens/login_screen/cubit/states.dart';
import 'package:softag/screens/login_screen/models.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool visibility = true;

  late UserModel userModel = UserModel();

  void changeVisibility() {
    visibility = !visibility;
    emit(LoginChangeState());
  }

  void login({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.init();
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print('i\m here');
      userModel = UserModel.fromJson(value.data);
      emit(LoginSuccessState());
    }).catchError((e) {
      print('Error Login Screen $e');
      emit(LoginErrorState());
    });
  }
}
