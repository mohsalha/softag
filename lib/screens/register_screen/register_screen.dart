import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:softag/components/components.dart';
import 'package:softag/components/consts.dart';
import 'package:softag/screens/register_screen/cubit/cubit.dart';
import 'package:softag/screens/register_screen/cubit/states.dart';
import 'package:softag/size_config.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RoundedLoadingButtonController _registerController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          var cubit = RegisterCubit.get(context);
          if (state is RegisterSuccessState) {
            if (cubit.userModel.data != null) {
              Fluttertoast.showToast(
                msg: cubit.userModel.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.greenAccent,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              Navigator.pop(context);
              return;
            }
            _registerController.reset();
            Fluttertoast.showToast(
                msg: cubit.userModel.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,);
            return;
          }
          if(state is RegisterVerifyPasswordState){
            _registerController.reset();
          }
        },
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
                      defaultButton(context,
                          controller: _registerController,
                          title: 'Sign Up', function: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.register(
                            password: _passwordController.text,
                            confirmPassword: _confirmController.text,
                            name: _nameController.text,
                            phone: _phoneController.text,
                            email: _emailController.text,
                          );
                        } else {
                          _registerController.reset();
                        }
                        return;
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
