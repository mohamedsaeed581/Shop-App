import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/components/components.dart';
import 'package:untitled/layout/bloc/cubit.dart';
import 'package:untitled/layout/bloc/states.dart';
import 'package:untitled/modules/search/search_screen.dart';

class ShopLayout extends StatelessWidget {
   ShopLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(onPressed: (){navigateTo(context, SearchScreen());}, icon: Icon(Icons.search))
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex ,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.category_outlined),label:'Categories' ),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
