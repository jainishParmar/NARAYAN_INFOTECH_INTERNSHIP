import 'package:flutter/material.dart';
import 'package:intern_final/pages/account/account_page.dart';
import 'package:intern_final/pages/cart/order_load_splash_screen.dart';
import 'package:intern_final/pages/home/main_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List pages = [
    const MainPage(),

    const OrderLoadSplashScreen(),

    Container(child: const Center(
      child: AccountPage(),
    ),),


  ];

  void onTapNav(int index){
    setState((){
      _selectedIndex=index;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar:BottomNavigationBar(
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.blue,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items: const  [
          BottomNavigationBarItem(icon:Icon( Icons.home_outlined,),
            label:"Home",),

          BottomNavigationBarItem(icon:Icon( Icons.shopping_cart_outlined,),
            label:"Orders",),
          BottomNavigationBarItem(icon:Icon( Icons.person,),
            label:"Me",)
        ],
      ),
    );
  }

}
