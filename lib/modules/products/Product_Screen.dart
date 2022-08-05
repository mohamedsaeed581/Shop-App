import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/bloc/cubit.dart';
import 'package:untitled/layout/bloc/states.dart';
import 'package:untitled/models/categories_model.dart';
import 'package:untitled/models/home_model.dart';
import 'package:untitled/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          backgroundColor: Colors.white,
body: ConditionalBuilder(
    condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
    builder: (context) => productsBuilder(ShopCubit.get(context).homeModel, ShopCubit.get(context).categoriesModel),
  fallback:(context) => Center(child: CircularProgressIndicator())  ,
),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model, CategoriesModel categoriesModel) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(items: model.data.banners.map((e) => Image(image: NetworkImage('${e.image}'),width: double.infinity,fit: BoxFit.cover,)).toList(),
            options: CarouselOptions(
              height: 160,
              initialPage: 0,
              viewportFraction: 1.00,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,

            ),),

        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categories',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                     itemBuilder: (context,index) => buildCategoryItem(categoriesModel.data.data[index]),
                    separatorBuilder: (context,index) => SizedBox(width: 10,),
                    itemCount: categoriesModel.data.data.length),
              ),
              SizedBox(height: 20,),
              Text('Products',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1/1.6,
            children: List.generate(model.data.products.length, (index) => buildGridProduct(model.data.products[index]) ),
          ),
        ),
      ],
    ),
  );
  Widget buildCategoryItem(DataModel model) => Container(
    height: 100,
    width: 100,
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(.8),
          width: double.infinity,
          child: Text(model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,

            ),
          ),
        ),
      ],
    ),
  );


  Widget buildGridProduct(ProductsModel model ) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image,),
              height: 200.0,
              width: double.infinity,
            ),
            if(model.discount != 0)
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
        Padding(
          padding: const EdgeInsets.all(12.0),
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
              Row(
                children: [
                  Text('${model.price.round()}',
                    style: TextStyle(fontSize: 12,
                      color: defaultColor,

                    ),
                  ),
                  SizedBox(width: 10,),
                  if(model.discount != 0)
                  Text('${model.oldPrice.round()}',
                    style: TextStyle(fontSize: 10,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),

                  Spacer(),
                  IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border))
                ],
              ),
            ],
          ),
        ),


      ],

    ),
  );
}
