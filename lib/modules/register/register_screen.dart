import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/components/components.dart';
import 'package:untitled/components/constant.dart';
import 'package:untitled/layout/shop_layout.dart';

import 'package:untitled/modules/register/cubit/cubit.dart';
import 'package:untitled/modules/register/cubit/states.dart';
import 'package:untitled/network/local/cacheHelper.dart';
import 'package:untitled/styles/colors.dart';

class RedisterScreen extends StatelessWidget {
   RedisterScreen({Key key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
   var emailController = TextEditingController();
   var passwordController = TextEditingController();
   var nameController = TextEditingController();
   var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (BuildContext context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.data.token);
              print(state.loginModel.message);
              CacheHelper.saveDate(
                  key: 'token', value: state.loginModel.data.token).then((value) {
                token = state.loginModel.data.token;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              print(state.loginModel.message);
              showToast(
                  text: state.loginModel.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        'Register now to browse our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: defaultColor),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          labelText: 'User Name',
                          prefixIcon:
                          Icon(Icons.person, color: defaultColor),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your name';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: defaultColor),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          labelText: 'Email Address',
                          prefixIcon:
                          Icon(Icons.email_outlined, color: defaultColor),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your email address';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: defaultColor),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          label: Text('Password'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          prefixIcon:
                          Icon(Icons.lock_outline, color: defaultColor),
                          suffixIcon: IconButton(
                              onPressed: () {
                                RegisterCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              icon: Icon(RegisterCubit.get(context).suffix)),
                        ),
                        obscureText: RegisterCubit.get(context).isPassword,
                        onFieldSubmitted: (value) {
                          // if (formKey.currentState.validate()) {
                          //   RegisterCubit.get(context).userRegister(
                          //       email: emailController.text,
                          //       password: passwordController.text);
                          // }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'password is too short';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: defaultColor),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          labelText: 'Phone',
                          prefixIcon:
                          Icon(Icons.phone, color: defaultColor),
                        ),
                        maxLength: 11,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your phone';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => Container(
                          width: double.infinity,
                          height: 50.0,
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                print(passwordController.text +
                                    emailController.text);
                                RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            child: Text(
                              'register'.toUpperCase(),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: defaultColor,
                          ),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
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
