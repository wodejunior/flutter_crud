
import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';


const _tituloAppBar = 'Formulário de Usuários';
const _fieldId = 'id';
const _fieldName = 'nome';
const _fieldEmail = 'email';
const _fieldAvatarUrl = 'avatarUrl';

const _lblTextName = 'Nome';
const _lblTextEmail = 'E-mail';
const _lblTextAvatarUrl = 'URL do Avatar';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if(user != null) {
      _formData[_fieldId] = user.id;
      _formData[_fieldName] = user.name;
      _formData[_fieldEmail] = user.email;
      _formData[_fieldAvatarUrl] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependenceis() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments as User;
    _loadFormData(user);
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState.validate();
              if(isValid) {
                _form.currentState.save();

                Provider.of<Users>(context, listen: false).put(User(
                  id: _formData[_fieldId],
                  name: _formData[_fieldName],
                  email: _formData[_fieldEmail],
                  avatarUrl: _formData[_fieldAvatarUrl],
                  ),
                );

                Navigator.of(context).pop();
              }
            },
          ),
        ]
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData[_fieldName],
                decoration: InputDecoration(
                  labelText: _lblTextName,
                ),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'Nome deve ser preenchido!';
                  }

                  if(value.trim().length < 3){
                    return 'Preencha o minimo de 3 letras.';
                  }
                  //return;
                },
                onSaved: (value) => _formData[_fieldName] = value,
              ),
              TextFormField(
                initialValue: _formData[_fieldEmail],
                decoration: InputDecoration(
                  labelText: _lblTextEmail,
                ),
                onSaved: (value) => _formData[_fieldEmail] = value,
              ),
              TextFormField(
                initialValue: _formData[_fieldAvatarUrl],
                decoration: InputDecoration(
                  labelText: _lblTextAvatarUrl,
                ),
                onSaved: (value) => _formData[_fieldAvatarUrl] = value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
