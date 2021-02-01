import 'package:flutter/material.dart';
import 'package:fluttercrud/models/user.dart';
import 'package:fluttercrud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formaData = {};

  void _loadFormData(User user) {
    if (user != null) {
      _formaData['id'] = user.id;
      _formaData['name'] = user.name;
      _formaData['email'] = user.email;
      _formaData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;

    _loadFormData(user);

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de usuario'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final isValid = _form.currentState.validate();

                if (isValid) {
                  _form.currentState.save();
                  Provider.of<Users>(context, listen: false).put(User(
                    id: _formaData['id'],
                    name: _formaData['name'],
                    email: _formaData['email'],
                    avatarUrl: _formaData['avatar'],
                  ));

                  Navigator.of(context).pop();
                }
              }),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formaData['name'],
                decoration: InputDecoration(labelText: 'Nome'),
                // ignore: missing_return
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome Ivalido';
                  }
                  if (value.trim().length <= 3) {
                    return 'Nome pequeno';
                  }
                  return null;
                },
                onSaved: (value) => _formaData['name'] = value,
              ),
              TextFormField(
                initialValue: _formaData['email'],
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => _formaData['email'] = value,
              ),
              TextFormField(
                initialValue: _formaData['avatarUrl'],
                decoration: InputDecoration(labelText: 'URL do Avatar'),
                onSaved: (value) => _formaData['avatarUrl'] = value,
              )
            ],
          ),
        ),
      ),
    );
  }
}
