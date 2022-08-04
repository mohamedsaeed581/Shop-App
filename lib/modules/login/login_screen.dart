import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/components/components.dart';
import 'package:untitled/layout/shop_layout.dart';
import 'package:untitled/modules/login/cubit/cubit.dart';
import 'package:untitled/modules/login/cubit/states.dart';
import 'package:untitled/modules/register/register_screen.dart';
import 'package:untitled/network/local/cacheHelper.dart';
import 'package:untitled/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LogingCubit(),
      child: BlocConsumer<LogingCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.data.token);
              print(state.loginModel.message);
              CacheHelper.saveDate(
                  key: 'token', value: state.loginModel.data.token).then((value) {
                    navigateAndFinish(context, ShopLayout());
              });
            } else {
              print(state.loginModel.message);
              showToast(
                  text: state.loginModel.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
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
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
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
                                  LogingCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                icon: Icon(LogingCubit.get(context).suffix)),
                          ),
                          obscureText: LogingCubit.get(context).isPassword,
                          onFieldSubmitted: (value) {
                            if (formKey.currentState.validate()) {
                              LogingCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
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
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            height: 50.0,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  print(passwordController.text +
                                      emailController.text);
                                  LogingCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              child: Text(
                                'login'.toUpperCase(),
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
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have account? '),
                            TextButton(
                              onPressed: () {
                                navigateAndFinish(context, RedisterScreen());
                              },
                              child: Text(
                                'register'.toUpperCase(),
                              ),
                            ),
                          ],
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
