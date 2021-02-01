import 'package:flutter/material.dart';
import 'package:fluttercrud/provider/users.dart';
import 'package:fluttercrud/routes/app_routes.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

class UserTitle extends StatelessWidget {
  final User user;

  const UserTitle(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.edit),
                color: Colors.orange,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.USER_FORM,
                    arguments: user,
                  );
                }),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text('Excluir Usuario'),
                          content: Text('tem certeza?'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Não'),
                            ),
                            FlatButton(
                              onPressed: () {
                                Provider.of<Users>(context, listen: false)
                                    .remove(user);
                                Navigator.of(context).pop();
                              },
                              child: Text('Sim'),
                            ),
                          ],
                        ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
