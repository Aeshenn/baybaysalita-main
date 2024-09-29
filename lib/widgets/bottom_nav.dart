import 'package:flutter/material.dart';
import 'package:trial_mobile/screens/category.dart';
import 'package:trial_mobile/screens/pagsasanay_dashboard.dart';
import 'package:trial_mobile/screens/profile.dart';

class BottomNav extends StatefulWidget {
   BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  void _navigateBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List <Widget> _children = [
    CategoryPage(),
    PagsasanayDashPage(),
    ProfilePage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _children[_selectedIndex],
      bottomNavigationBar: Container(
         decoration: BoxDecoration(
        color: Colors.transparent,
        backgroundBlendMode: BlendMode.clear,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      height: MediaQuery.of(context).size.height * 0.085,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
        child: BottomNavigationBar(
          backgroundColor:  Color.fromARGB(255, 255, 255, 255),
          elevation: 5,
          fixedColor: Color(0xfff5505b),
          currentIndex: _selectedIndex,
          onTap: _navigateBottomNavBar,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.category_outlined), label: 'pagsasanay'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
          ],
         ),
      ),
    )
    );
  }
}