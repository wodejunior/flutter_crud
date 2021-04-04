import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = 'Cadastro de Usuário';
const _fieldId = 'id';
const _fieldName = 'name';
const _fieldEmail = 'email';
const _fieldAvatarUrl = 'avatarUrl';

const _lbTextId = 'id';
const _lbTextNome = 'Nome';
const _lbTextEmail = 'E-mail';
const _lbTextAvatarUrl = 'Url do Avatar';

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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final User user = ModalRoute.of(context).settings.arguments as User;
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState.validate();
              if (isValid) {
                _form.currentState.save();

                Provider.of<Users>(context, listen: false).put(
                  User(
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
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child:
          Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _formData[_fieldName],
                  decoration: InputDecoration(
                    labelText: _lbTextNome,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'O nome deve ser preenchido';
                    }

                    if (value.trim().length < 3) {
                      return 'Nome deve ter no mínimo 3 letras.';
                    }

                    return null;
                  },
                  onSaved: (value) => _formData[_fieldName] = value,
                ),
                TextFormField(
                  initialValue: _formData[_fieldEmail],
                  decoration: InputDecoration(
                    labelText: _lbTextEmail,
                  ),
                  onSaved: (value) => _formData[_fieldEmail] = value,
                ),
                TextFormField(
                  initialValue: _formData[_fieldAvatarUrl],
                  decoration: InputDecoration(
                    labelText: _lbTextAvatarUrl,
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
