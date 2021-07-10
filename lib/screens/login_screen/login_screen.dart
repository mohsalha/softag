import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:softag/components/components.dart';
import 'package:softag/components/consts.dart';
import 'package:softag/controller/app_controller.dart';
import 'package:softag/screens/login_screen/cubit/cubit.dart';
import 'package:softag/screens/login_screen/cubit/states.dart';
import 'package:softag/size_config.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RoundedLoadingButtonController _loginController =
      RoundedLoadingButtonController();

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          var cubit = LoginCubit.get(context);
          if (state is LoginSuccessState) {
            if (cubit.userModel.data != null) {
              AppController.instance.savaUser(cubit.userModel.data!);
            Future.delayed(Duration(seconds: 3),(){  Navigator.pushNamedAndRemoveUntil(
                context, '/main_screen', (route) => false);});
              return;
            }
            if (cubit.userModel.status == false) {
              Fluttertoast.showToast(
                  msg: cubit.userModel.message!,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
            _loginController.reset();
            return;
          }
          if (state is LoginErrorState) {
            Fluttertoast.showToast(
              msg: 'Error!',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            _loginController.reset();
            return;
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.scaleWidth(34),
                  vertical: SizeConfig.scaleHeight(20),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      titleScreen(title: 'Login'),
                      SizedBox(
                        height: SizeConfig.scaleHeight(12),
                      ),
                      desScreen(des: 'Add your details to login'),
                      SizedBox(
                        height: SizeConfig.scaleHeight(36),
                      ),
                      defaultFromField(
                        prefix: Icons.email_outlined,
                        controller: _emailController,
                        validatorString: 'Enter Email Please',
                        label: 'Your Email',
                        keyboard: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(28),
                      ),
                      defaultFromField(
                        prefix: Icons.lock_outline,
                        controller: _passwordController,
                        validatorString: 'Enter Password Please',
                        label: 'Password',
                        obscureText: cubit.visibility,
                        needSuffix: true,
                        suffix: cubit.visibility
                            ? Icons.visibility
                            : Icons.visibility_off,
                        function: () {
                          cubit.changeVisibility();
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(28),
                      ),
                      defaultButton(context,
                          controller: _loginController,
                          title: 'Login', function: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.login(
                              email: _emailController.text,
                              password: _passwordController.text);
                        } else {
                          _loginController.reset();
                          return;
                        }
                        return;
                      }),
                      SizedBox(
                        height: SizeConfig.scaleHeight(24),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot your password?',
                          style: TextStyle(
                            fontSize: SizeConfig.scaleTextFont(14),
                            color: greyColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(15),
                      ),
                      defaultRichText(
                          startTitle: 'Don\'t have an Account? ',
                          endTitle: 'Sign Up',
                          function: () {
                            Navigator.pushNamed(context, '/register_screen');
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softag/components/components.dart';
import 'package:softag/components/consts.dart';
import 'package:softag/screens/register_screen/cubit/cubit.dart';
import 'package:softag/screens/register_screen/cubit/states.dart';
import 'package:softag/size_config.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.scaleWidth(34),
                  vertical: SizeConfig.scaleHeight(20),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      titleScreen(title: 'Sign Up'),
                      SizedBox(
                        height: SizeConfig.scaleHeight(12),
                      ),
                      desScreen(des: 'Add your details to sign up'),
                      SizedBox(
                        height: SizeConfig.scaleHeight(36),
                      ),
                      defaultFromField(
                        prefix: Icons.person,
                        controller: _nameController,
                        validatorString: 'Enter Name Please',
                        label: 'Name',
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(28),
                      ),
                      defaultFromField(
                        prefix: Icons.email_outlined,
                        controller: _emailController,
                        validatorString: 'Enter Email Please',
                        label: 'Email',
                        keyboard: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(28),
                      ),
                      defaultFromField(
                        prefix: Icons.phone_android_outlined,
                        controller: _phoneController,
                        validatorString: 'Enter Mobile Number Please',
                        label: 'Mobile No',
                        keyboard: TextInputType.number,
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(28),
                      ),
                      defaultFromField(
                        prefix: Icons.location_city,
                        controller: _addressController,
                        validatorString: 'Enter Address Please',
                        label: 'Adrress',
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(28),
                      ),
                      defaultFromField(
                        prefix: Icons.lock_outline,
                        controller: _passwordController,
                        validatorString: 'Enter Password Please',
                        label: 'Password',
                        obscureText: cubit.visibility,
                        needSuffix: true,
                        suffix: cubit.visibility
                            ? Icons.visibility
                            : Icons.visibility_off,
                        function: () {
                          cubit.changeVisibility();
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(28),
                      ),
                      defaultFromField(
                        prefix: Icons.lock_outline,
                        controller: _confirmController,
                        validatorString: 'Confirm Password Please',
                        label: 'Confirm Password',
                        obscureText: cubit.visibilityConfirm,
                        needSuffix: true,
                        suffix: cubit.visibilityConfirm
                            ? Icons.visibility
                            : Icons.visibility_off,
                        function: () {
                          cubit.changeVisibilityConfirm();
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.scaleHeight(28),
                      ),
                      defaultButton(
                          title: 'Sign Up',
                          function: () {
                            if (_formKey.currentState!.validate()) {

                            }return;
                          }),
                      SizedBox(
                        height: SizeConfig.scaleHeight(24),
                      ),
                      defaultRichText(
                        startTitle: 'Do you have an Account? ',
                        endTitle: 'Login',
                        function: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login_screen', (route) => false);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
*/
