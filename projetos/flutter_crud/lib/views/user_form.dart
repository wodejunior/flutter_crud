import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

const _tituloAppBar    = 'Cadastro de Usuário';
const _lbTextNome      = 'Nome';
const _lbTextEmail     = 'E-mail';
const _lbTextAvatarUrl = 'Url do Avatar';

class UserForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, Object> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( _tituloAppBar ),
        actions: <Widget> [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState.validate();
              if(isValid){
                _form.currentState.save();

                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    name: _formData['name'],
                    email: _formData['email'],
                    avatarUrl: _formData['avatarUrl'],
                  ),
                );

                Navigator.of(context).pop();
              };
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: _lbTextNome,
                ),
                validator: (value) {
                  if(value == null || value.trim().isEmpty) {
                    return 'O nome deve ser preenchido';
                  }

                  if(value.trim().length < 3) {
                    return 'Nome deve ter no mínimo 3 letras.';
                  }
                },
                onSaved: (value) => _formData['name'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: _lbTextEmail,
                ),
                onSaved: (value) => _formData['email'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: _lbTextAvatarUrl,
                ),
                onSaved: (value) => _formData['avatarUrl'] = value,
              ),
            ],
          )
        ),
      ),
    );
  }
}
