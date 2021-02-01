import 'package:flutter/material.dart';
import 'package:fluttercrud/components/user_tile.dart';
import 'package:fluttercrud/provider/users.dart';
import 'package:fluttercrud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de usuarios'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.USER_FORM);
                }),
          ],
        ),
        body: ListView.builder(
          itemCount: users.count,
          itemBuilder: (ctx, i) => UserTitle(users.byIdex(i)),
        ));
  }
}
