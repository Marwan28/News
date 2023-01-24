import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child: Container(),),
          ListTile(
            onTap: (){Navigator.of(context).pushNamed('/saved');},
            title: Text('Saved'),
          ),

        ],
      ),
    );
  }
}
