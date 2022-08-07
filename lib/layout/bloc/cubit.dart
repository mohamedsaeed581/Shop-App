import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/components/components.dart';
import 'package:untitled/components/constant.dart';
import 'package:untitled/layout/bloc/states.dart';
import 'package:untitled/models/categories_model.dart';
import 'package:untitled/models/change_favorites_model.dart';
import 'package:untitled/models/favorites_model.dart';
import 'package:untitled/models/home_model.dart';
import 'package:untitled/models/login_model.dart';
import 'package:untitled/modules/categories/categories_screen.dart';
import 'package:untitled/modules/favorites/favorites_screen.dart';
import 'package:untitled/modules/login/login_screen.dart';
import 'package:untitled/modules/products/Product_Screen.dart';
import 'package:untitled/modules/products/products_screen.dart';
import 'package:untitled/modules/search/search_screen.dart';
import 'package:untitled/modules/settings/settings_screen.dart';
import 'package:untitled/network/end_point/end_points.dart';
import 'package:untitled/network/local/cacheHelper.dart';
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
Map <int, bool> favorites = {};

void getHomeData(){
  emit(ShopLoadingHomeDataState());

  DioHelper.getData(url: HOME,token: token,).then((value) {
    homeModel = HomeModel.fromJson(value.data);
    // print(homeModel.toString());
    // print(homeModel.data.banners[0].image);

    homeModel.data.products.forEach((element) {
      favorites.addAll({element.id : element.inFavorites});
    });
    print(favorites.toString());
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

ChangeFavoritesModel changeFavoritesModel;

void changeFavorites (int productId){
  favorites[productId] = !favorites[productId];
  emit(ShopChangeFavoritesState());

  DioHelper.postData(
    url: FAVORITES,
    token: token,
    data: {'product_id' : productId},

  ).then((value) {
    changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
    if(!changeFavoritesModel.status) {
      favorites[productId] = !favorites[productId];
    }else{
      getFavoritesData();
    }
    emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
  }).catchError((error){
    favorites[productId] = !favorites[productId];
    emit(ShopErrorChangeFavoritesState());
  });
}

FavoritesModel favoritesModel;

void getFavoritesData(){
  emit(ShopLoadingGetFavoritesState());
  DioHelper.getData(
      url: FAVORITES,
    token: token,
  ).then((value) {
    favoritesModel = FavoritesModel.fromJson(value.data);
    emit(ShopSuccessFavoritesState());
  }).catchError((error){
emit(ShopErrorFavoritesState());
  });
}

  LoginModel userModel;

  void getUserData(){
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error){
      emit(ShopErrorUserDataState());
    });
  }

  void putUserData(
  {
@required String name,
@required String email,
@required String phone,
})
{
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name' : name,
        'email' : email,
        'phone' : phone,
      }
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserDataState(userModel));
    }).catchError((error){
      emit(ShopErrorUpdateUserDataState());
    });
  }

  void signOut (context){
    CacheHelper.removeData(
      key: 'token',).then((value) {
        if(value){
          navigateAndFinish(context, LoginScreen());
        }
    });
  }
}