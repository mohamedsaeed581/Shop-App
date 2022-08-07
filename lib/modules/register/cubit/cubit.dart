import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/login_model.dart';
import 'package:untitled/modules/login/cubit/states.dart';
import 'package:untitled/modules/register/cubit/states.dart';
import 'package:untitled/network/end_point/end_points.dart';
import 'package:untitled/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
LoginModel loginModel;
  void changePasswordVisibility(){
    isPassword = !isPassword;

    suffix =isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

  void userRegister({
    String email,
    String name,
    String phone,
    String password,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER,
        data:  {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,},
    ).then((value) {

      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });
  }
}
