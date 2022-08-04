// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:untitled/layout/bloc/cubit.dart';
// import 'package:untitled/layout/bloc/states.dart';
// import 'package:untitled/models/home_model.dart';
// import 'package:untitled/styles/colors.dart';
//
// class ProductsScreen extends StatelessWidget {
//   const ProductsScreen({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ShopCubit, ShopStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var cubit = ShopCubit.get(context);
//         return ConditionalBuilder(
//           condition: cubit.homeModel != null,
//           builder: (context) =>     SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CarouselSlider(
//                     items:  cubit.homeModel.data.banners.map((e) {
//                       Image(
//                         image: NetworkImage('${e.image}'),
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                       );
//                     }).toList(),
//                     options: CarouselOptions(
//                       height: 250,
//                       initialPage: 0,
//                       enableInfiniteScroll: true,
//                       reverse: false,
//                       autoPlay: true,
//                       autoPlayInterval: Duration(seconds: 3),
//                       autoPlayAnimationDuration: Duration(seconds: 1),
//                       autoPlayCurve: Curves.fastOutSlowIn,
//                       scrollDirection: Axis.horizontal,
//                       viewportFraction: 1.0,
//                     )),
//                 SizedBox(height: 10),
//                 Container(
//                   color: Colors.grey[300],
//                   child: GridView.count(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 1,
//                       crossAxisSpacing: 1,
//                       childAspectRatio: 1/1.6,
//                       children: List.generate(cubit.homeModel.data.products.length,
//                               (index) => buildGridProduct(cubit.homeModel.data.products[index]))),
//                 ),
//               ],
//             ),
//           )
//           ,
//           fallback: (context) => const Center(child: CircularProgressIndicator()),
//         );
//       },
//     );
//   }
//
//   Widget productsBuilder(HomeModel model) {
//   }
//
//   Widget buildGridProduct(Products model) {
//     Container(
//       color: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             alignment: AlignmentDirectional.bottomStart,
//             children: [
//               Image(
//                 image: NetworkImage(model.image),
//                 width: double.infinity,
//                 height: 200,
//                 // fit: BoxFit.cover,
//
//               ),
//               if(model.discount != 0)
//                 Container(
//                   color: Colors.red,
//                   padding: EdgeInsets.symmetric(horizontal: 5),
//                   child: Text('DISCOUNT',
//                     style: TextStyle(
//                       fontSize: 8,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               children: [
//                 Text('${model.name}',
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       fontSize: 14,
//                       height: 1.3
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Text('${model.price.round()}',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: defaultColor,
//
//                       ),
//                     ),
//                     SizedBox(width: 5),
//                     if(model.discount != 0)
//                       Text('${model.oldPrice.round()}',
//                         style: TextStyle(
//                           fontSize: 10,
//                           color: Colors.grey,
//                           decoration: TextDecoration.lineThrough,
//                         ),
//                       ),
//                     Spacer(),
//                     IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border,size: 12,))
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
