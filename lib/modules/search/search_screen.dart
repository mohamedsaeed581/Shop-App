import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/bloc/cubit.dart';
import 'package:untitled/models/search_model.dart';
import 'package:untitled/modules/search/cubit/cubit.dart';
import 'package:untitled/modules/search/cubit/states.dart';
import 'package:untitled/styles/colors.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key key}) : super(key: key);
var formKey = GlobalKey<FormState>();
 var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: defaultColor),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelText: 'Search',

                        prefixIcon:
                        Icon(Icons.search, color: defaultColor),
                      ),
                      onFieldSubmitted: (String text){
                        SearchCubit.get(context).search(text);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'enter text to search';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    if (state is SearchLoadingState)
                    LinearProgressIndicator(),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder:(context,index) =>   buildFavItem(SearchCubit.get(context).searchModel.data.data[index],context),
                          separatorBuilder:(context,index) =>  SizedBox(height: 5,),
                          itemCount: SearchCubit.get(context).searchModel.data.data.length),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

  }
   Widget buildFavItem( model,context) => Padding(
     padding: const EdgeInsets.all(20.0),
     child: Container(
       height: 120,
       child: Row(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Stack(
             alignment: AlignmentDirectional.bottomStart,
             children: [
               Image(
                 image: NetworkImage(model.image,),
                 height: 120.0,
                 width: 120,
               ),
              // if(model.discount != 0)
                 // Container(
                 //   color: Colors.red,
                 //   child: Padding(
                 //     padding: const EdgeInsets.symmetric(horizontal: 5.0),
                 //     child: Text('DISCOUNT',
                 //       style: TextStyle(
                 //         fontSize: 9,
                 //         color: Colors.white,
                 //       ),),
                 //   ),
                 // ),
             ],
           ),
           SizedBox(width: 20,),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text('${model.name}',
                   maxLines: 2,
                   overflow: TextOverflow.ellipsis,
                   style: TextStyle(fontSize: 14,
                       height: 1.3
                   ),
                 ),
                 Spacer(),
                 Row(
                   children: [
                     Text('${model.price.toString()}',
                       style: TextStyle(fontSize: 12,
                         color: defaultColor,

                       ),
                     ),
                     SizedBox(width: 10,),


                     Spacer(),
                     IconButton(onPressed: (){
                       ShopCubit.get(context).changeFavorites(model.id);

                     },
                       icon: CircleAvatar(
                         radius: 15,
                         backgroundColor: ShopCubit.get(context).favorites[model.id] ? defaultColor: Colors.grey,
                         child: Icon(Icons.favorite_border,size: 15,
                           color: Colors.white,
                         ),),),
                   ],
                 ),
               ],
             ),
           ),


         ],

       ),
     ),
   );

}
