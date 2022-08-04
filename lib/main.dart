import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/bloc/cubit.dart';
import 'package:untitled/layout/shop_layout.dart';
import 'package:untitled/modules/login/login_screen.dart';
import 'package:untitled/modules/on_boarding/on_boarding_screen.dart';
import 'package:untitled/network/local/cacheHelper.dart';
import 'package:untitled/network/remote/dio_helper.dart';
import 'package:untitled/styles/themes.dart';

import 'components/constant.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool onBoarding = CacheHelper.getDate(key: 'onBoarding');
   token= CacheHelper.getDate(key: 'token');
  bool isDark = CacheHelper.getDate(key: 'isDark');
  if(onBoarding != null){
    if(token != null){
      widget = ShopLayout();
    }
    else {LoginScreen();}

  }
  else{
    widget = OnBoardingScreen();
  }

  runApp( MyApp(startWidget: widget,isDark: isDark,));
}



class MyApp extends StatelessWidget {
final Widget startWidget;
final bool isDark;
MyApp({this.startWidget, this.isDark});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ShopCubit()..getHomeData(),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        home:  startWidget,
      ),
    );
  }
}


