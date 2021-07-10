import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:softag/components/components.dart';
import 'package:softag/components/consts.dart';
import 'package:softag/controller/app_controller.dart';
import 'package:softag/screens/main_screen/cubit/cubit.dart';
import 'package:softag/screens/main_screen/cubit/states.dart';
import 'package:softag/size_config.dart';

class MoreScreen extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RoundedLoadingButtonController _updateController =
      RoundedLoadingButtonController();
  RoundedLoadingButtonController _logoutController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        var cubit = MainCubit().get(context);
        if (state is MainSuccessUpdateState) {
          if (cubit.userModel!.data != null) {
            Fluttertoast.showToast(
              msg: cubit.userModel!.message!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.white,
              fontSize: 16.0,
            );

            return;
          }
          _updateController.reset();
          Fluttertoast.showToast(
            msg: cubit.userModel!.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,);
          return;
        }

      },
      builder: (context, state) {
        var cubit = MainCubit().get(context);


         if(cubit.userModel != null){
           _nameController.text = cubit.userModel!.data!.name! ;
           _phoneController.text = cubit.userModel!.data!.phone! ;
           _emailController.text = cubit.userModel!.data!.email!;
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update Profile Now',
                    style: TextStyle(
                      fontSize: SizeConfig.scaleTextFont(18),
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.scaleHeight(20),
                  ),
                  if (state is MainLoadingUpdateState)
                    LinearProgressIndicator(),
                  if (state is MainLoadingUpdateState)
                    SizedBox(
                      height: SizeConfig.scaleHeight(15),
                    ),
                  defaultFromField(
                    controller: _nameController,
                    validatorString: 'Enter name please',
                    label: 'Name',
                    prefix: Icons.person,
                  ),
                  SizedBox(
                    height: SizeConfig.scaleHeight(15),
                  ),
                  defaultFromField(
                      controller: _phoneController,
                      validatorString: 'Enter phone please',
                      label: 'Phone',
                      prefix: Icons.phone,
                      keyboard: TextInputType.number),
                  SizedBox(
                    height: SizeConfig.scaleHeight(15),
                  ),
                  defaultFromField(
                      controller: _emailController,
                      validatorString: 'Enter email please',
                      label: 'Email',
                      prefix: Icons.person,
                      keyboard: TextInputType.emailAddress),
                  SizedBox(
                    height: SizeConfig.scaleHeight(20),
                  ),

                  defaultButton(context,
                      controller: _updateController,
                      title: 'Update', function: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.updateUserData(
                            name: _nameController.text,
                            phone: _phoneController.text,
                            email: _emailController.text,
                          );
                          return;
                        } else {
                          _updateController.reset();
                        }
                        return;
                      }),
                  SizedBox(
                    height: SizeConfig.scaleHeight(20),
                  ),
                  defaultButton(
                    context,
                    title: 'logout',
                    function: () {
                      AppController.instance.logout();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login_screen', (route) => false);
                      return;
                    },
                    controller: _logoutController,
                  ),
                ],
              ),
            ),
          );}else{return Center(child: CircularProgressIndicator());}

      },
    );
  }
}
