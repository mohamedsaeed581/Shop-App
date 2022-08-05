import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/components/constant.dart';
import 'package:untitled/layout/bloc/states.dart';
import 'package:untitled/models/categories_model.dart';
import 'package:untitled/models/home_model.dart';
import 'package:untitled/modules/categories/categories_screen.dart';
import 'package:untitled/modules/favorites/favorites.dart';
import 'package:untitled/modules/products/Product_Screen.dart';
import 'package:untitled/modules/products/products_screen.dart';
import 'package:untitled/modules/search/search_screen.dart';
import 'package:untitled/modules/settings/settings_screen.dart';
import 'package:untitled/network/end_point/end_points.dart';
import 'package:untitled/network/remote/dio_helper.dart';

class ShopCubit extends Cubit <ShopStates>{

  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

int currentIndex = 0;

List<Widget> bottomScreens = [
  ProductsScreen(),
  CategoriesScreen(),
  FavoritesScreen(),
  SettingsScreen(),

];

void changeBottom (int index){
currentIndex = index;
emit(ShopChangeBottomNavState());
}

HomeModel homeModel;

void getHomeData(){
  emit(ShopLoadingHomeDataState());

  DioHelper.getData(url: HOME,token: token,).then((value) {
    homeModel = HomeModel.fromJson(value.data);
    print(homeModel.toString());
    print(homeModel.data.banners[0].image);
    emit(ShopSuccessHomeDataState());
  }).catchError((error){
    print(error.toString());
    ShopErrorHomeDataState();
  });

}

CategoriesModel categoriesModel;

void getCategoriesData() {
  DioHelper.getData(
      url: GET_CATEGORIES
  
  ).then((value) {
    categoriesModel = CategoriesModel.fromJson(value.data);
    emit(ShopSuccessCategoriesState());
  }).catchError((error){
    emit(ShopErrorCategoriesState());
  });
}
}