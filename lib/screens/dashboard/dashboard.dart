import 'package:flutter/material.dart';
import 'package:pebbles/model/user_model.dart';
import 'package:pebbles/provider/auth.dart';
import 'package:pebbles/screens/dashboard/carts.dart/carts_page.dart';
import 'package:pebbles/screens/dashboard/chatadmin/chat_admin_page.dart';
import 'package:pebbles/screens/dashboard/home/home.dart';
import 'package:pebbles/screens/dashboard/wallet/wallet.dart';
import 'package:provider/provider.dart';

import './widgets/app_drawer.dart';

import '../../constants.dart';

class Dashboard extends StatefulWidget {
  int pageIndex;
  Dashboard(this.pageIndex);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String, dynamic>> _pages;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  UserModel user = UserModel();
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedPageIndex = widget.pageIndex;

    _pages = [
      {
        "title": "Home",
        "icon": "assets/images/HouseSimple.png",
        "screen": HomePage()
      },
      {
        "title": "Wallet",
        "icon": "assets/images/Wallet.png",
        "screen": WalletPage()
      },
      // {
      //   "title": "Voucher",
      //   "icon": "assets/images/Receipt.png",
      //   "screen": Text("")
      // },
      {
        "title": "Cart",
        "icon": "assets/images/ShoppingCartSimple.png",
        "screen": CartsPage()
      },
      {
        "title": "Admin",
        "icon": "assets/images/ChatCircleDots.png",
        "screen": ChatAdminPage()
      },
    ];
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Exit",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              "Are you sure you want to exit the App?",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              FlatButton(
                child: Text("NO"),
                onPressed: () {
                  return Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text("YES"),
                onPressed: () {
                  return Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    user = auth.user;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.grey.withOpacity(0.2),
          title: Text(
            "${_pages[_selectedPageIndex]["title"]}",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(kProfile);
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "${user.profilePhoto}",
                  ),
                  backgroundColor: Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
            elevation: 0,
            onTap: _selectPage,
            currentIndex: _selectedPageIndex,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  "${_pages[0]['icon']}",
                  height: 16,
                  fit: BoxFit.contain,
                ),
                label: "${_pages[0]['title']}",
                activeIcon: Image.asset("${_pages[0]['icon']}",
                    height: 20,
                    fit: BoxFit.contain,
                    color: Theme.of(context).primaryColor),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "${_pages[1]['icon']}",
                  height: 16,
                  fit: BoxFit.contain,
                ),
                label: "${_pages[1]['title']}",
                activeIcon: Image.asset("${_pages[1]['icon']}",
                    height: 20,
                    fit: BoxFit.contain,
                    color: Theme.of(context).primaryColor),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "${_pages[2]['icon']}",
                  height: 16,
                  fit: BoxFit.contain,
                ),
                label: "${_pages[2]['title']}",
                activeIcon: Image.asset("${_pages[2]['icon']}",
                    height: 20,
                    fit: BoxFit.contain,
                    color: Theme.of(context).primaryColor),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "${_pages[3]['icon']}",
                  height: 16,
                  fit: BoxFit.contain,
                ),
                label: "${_pages[3]['title']}",
                activeIcon: Image.asset("${_pages[3]['icon']}",
                    height: 20,
                    fit: BoxFit.contain,
                    color: Theme.of(context).primaryColor),
              ),
              // BottomNavigationBarItem(
              //   icon: Image.asset(
              //     "${_pages[4]['icon']}",
              //     height: 16,
              //     fit: BoxFit.contain,
              //   ),
              //   title: Text(
              //     "${_pages[4]['title']}",
              //   ),
              //   activeIcon: Image.asset("${_pages[4]['icon']}",
              //       height: 20,
              //       fit: BoxFit.contain,
              //       color: Theme.of(context).primaryColor),
              // ),
            ],
          ),
        ),
        body: _pages[_selectedPageIndex]["screen"],
      ),
    );
  }
}
