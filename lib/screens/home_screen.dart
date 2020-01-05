//import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:digicard/bottomnavscreens/infoupdate_screen.dart';
import 'package:digicard/bottomnavscreens/search_screen.dart';
import 'package:digicard/bottomnavscreens/realhome_screen.dart';

class HomeScreen extends StatefulWidget {
   static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
      final _auth =  FirebaseAuth.instance;    
  FirebaseUser loggedInUser;
  @override
  void initState() {
    
    super.initState();
    getCurrentUser();
  }
   void getCurrentUser() async 
   {
     try{
     final user = await _auth.currentUser();
     if(user!=null)
     {
        loggedInUser =user;
        print(loggedInUser.email);
        print(loggedInUser.uid);
        
        
     }
     }
     catch(e)
     {
       print(e);
     }

   } 
  int _currentindex =0;
  final List<Widget> _list =[        /** bottom navigatino bar ko lagi widigt ko list make gareko  */
    RealhomeScreen(),
    Searchscreen(),
    Infoscreen(),

  ];
  void onTappedBar(int index)    //ontap ko lagi function banako 
  {
    setState(() {
      _currentindex = index;
    });
  }


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
       leading: null,
       elevation:0.0,
        centerTitle: true,
      
        title: Text(
          'DigiCard',
         textAlign: TextAlign.center,
         ),
       
        
      ),
      //side menu bar create hunxa
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('anup maharjan'),
              accountEmail: Text('hellen7203@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('H',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                 )
                 
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
              title: Text('MyCard'),
               leading: Icon(Icons.credit_card),
               onTap: (){
                 Navigator.of(context).pushNamed('/mycard');
               },
              ),
            ),
              InkWell(
              onTap: (){},
              child: ListTile(
              title: Text('My account'),
               leading: Icon(Icons.person),
              ),
            ),
             InkWell(
              onTap: (){},
              child: ListTile(
              title: Text('Settings'),
               leading: Icon(Icons.settings),
              ),
              ),
                InkWell(
              onTap: (){},
              child: ListTile(
              title: Text('About'),
               leading: Icon(Icons.help),
              ),
            ),
              InkWell(
            
              child: ListTile(
              title: Text('Log Out'),
               leading: Icon(Icons.exit_to_app),
               onTap: () async{
                 FirebaseAuth.instance.signOut()
                 .then((value){
                 Navigator.of(context).pushReplacementNamed('/landingpage');
                 }).catchError((e){
                   print(e);
                 });
               },
              ),
            ),
          ],
        ),
        
      ),
      
      body:_list[_currentindex],// widget ko list yeta call hunxa 

      bottomNavigationBar: BottomNavigationBar(
         onTap: onTappedBar,
         currentIndex: _currentindex,
        items:[
          BottomNavigationBarItem (
            
            icon:Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem (
            icon:Icon(Icons.search),
            title: Text('search'),
          ),
          BottomNavigationBarItem (
            icon:Icon(Icons.info),
            title: Text('AddYourInfo'),
          ),
          
        ],
      ),
      
    );
    
  }
}


