import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/login_model.dart';
import 'package:untitled/modules/login/cubit/states.dart';
import 'package:untitled/network/end_point/end_points.dart';
import 'package:untitled/network/remote/dio_helper.dart';

class LogingCubit extends Cubit<LoginStates> {
  LogingCubit() : super(LoginInitialState());

  static LogingCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
LoginModel loginModel;
  void changePasswordVisibility(){
    isPassword = !isPassword;

    suffix =isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }

  void userLogin({
    String email,
    String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN,
        data:  {
          'email': email,
          'password': password,
        },
    ).then((value) {

      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }
}
