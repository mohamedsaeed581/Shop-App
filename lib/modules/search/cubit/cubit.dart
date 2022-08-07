import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/components/constant.dart';
import 'package:untitled/models/search_model.dart';
import 'package:untitled/modules/search/cubit/states.dart';
import 'package:untitled/network/end_point/end_points.dart';
import 'package:untitled/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel;

  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text ,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
    });
  }

}