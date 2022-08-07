import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/bloc/cubit.dart';
import 'package:untitled/layout/bloc/states.dart';
import 'package:untitled/models/favorites_model.dart';
import 'package:untitled/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          backgroundColor: Colors.white,
          body: ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoritesState,
            builder: (context) =>ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder:(context,index) =>  ShopCubit.get(context).favoritesModel.data.data.isNotEmpty  ? buildFavItem(ShopCubit.get(context).favoritesModel.data.data[index].product,context): Center(child: Text('NO ITEMS',style: TextStyle(fontSize: 30,color: Colors.black),)),
                separatorBuilder:(context,index) =>  SizedBox(height: 5,),
                itemCount: ShopCubit.get(context).favoritesModel.data.data.length),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    ) ;
  }
  Widget buildFavItem(model,context) => Padding(
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
                image: NetworkImage(model.product.image,),
                height: 120.0,
                width: 120,
              ),
              if(model.product.discount != 0)
                Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text('DISCOUNT',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.white,
                      ),),
                  ),
                ),
            ],
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${model.product.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14,
                      height: 1.3
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text('${model.product.price.toString()}',
                      style: TextStyle(fontSize: 12,
                        color: defaultColor,

                      ),
                    ),
                    SizedBox(width: 10,),
                    if(model.product.discount != 0)
                      Text('${model.product.oldPrice.toString()}',
                        style: TextStyle(fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),

                    Spacer(),
                    IconButton(onPressed: (){
                      ShopCubit.get(context).changeFavorites(model.product.id);

                    },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor: ShopCubit.get(context).favorites[model.product.id] ? defaultColor: Colors.grey,
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
