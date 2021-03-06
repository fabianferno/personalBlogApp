import 'package:flutter/material.dart';
import 'package:hello_world_flutter/login.dart';
import 'package:hello_world_flutter/main.dart';
import 'pushpop.dart';
import 'main.dart';
import 'snackbar_demo.dart';
import 'Webview_demo.dart';
import 'Calculator.dart';

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class HomeScreen extends StatefulWidget {

  var drawerItems = [
    new DrawerItem("Login", Icons.vpn_key),
    new DrawerItem("Blog", Icons.book),
    new DrawerItem("Stacker Exercise", Icons.tab),
    new DrawerItem("Snackbar", Icons.space_bar),
    new DrawerItem("Fabrowser", Icons.web),
    new DrawerItem("Basic Calculator", Icons.account_balance_wallet),
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  BuildContext _ctx;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return LoginPage();
        break;
      case 1:
        return BioData();
        break;
      case 2:
        return Stacker();
        break;
      case 3:
        return SnackbarDemo();
        break;
      case 4:
        return Fabrowser();
        break;
      case 5:
        return Calculator();
        break;
      default:
        return new Text("Error");
        break;
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var drawerOptions = <Widget>[];

    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      if (i == 7) {
        drawerOptions.add(
          const Divider(height: 1.0, color: Colors.grey),
        );
      }
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon,color: Colors.tealAccent,),
        title: new Text(d.title,style: TextStyle(color: Colors.tealAccent),),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        backgroundColor: Colors.black87,
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(
          widget.drawerItems[_selectedDrawerIndex].title,
        ),
      ),
      drawer: new Drawer(
        child: SingleChildScrollView(
          child: Container(
            height: 800,
            color: Colors.black87,
            child: new Column(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: new Text("Fabian Ferno"),
                  accountEmail: new Text("@super.skywalker"),
                  currentAccountPicture: CircleAvatar(
                    radius: 60.0,
                    backgroundColor: Colors.black87,
                    backgroundImage: NetworkImage("https://i.pinimg.com/originals/d5/51/2b/d5512bab9961e7a5c599bcf16250a9ed.jpg"), // for Network image
                  ),
                  decoration: new BoxDecoration(
                    color: Color(0xff101010),
                  ),
                ),
                new Column(children: drawerOptions)
              ],
            ),
          ),
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}