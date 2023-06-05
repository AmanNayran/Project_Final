import 'package:flutter/material.dart';

import '../database/database.dart';
import '../models/contact_model.dart';


class MyContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<MyContactsPage> {
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _databaseHelper = DatabaseHelper();
  List<ContactModel> _contacts = [];
  
  get id => null;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  void _fetchContacts() async {
    final contacts = await _databaseHelper.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  void _createContact() async {
    final name = _nameController.text;
    final phone = _phoneController.text;

    final contact = ContactModel(name: name, phone: phone, id: id);
    final contactId = await _databaseHelper.insertContact(contact);

    if (contactId != null) {
      _nameController.clear();
      _phoneController.clear();
      _fetchContacts();
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro'),
          content: const Text('Ocorreu um erro ao criar o contato.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  void _updateContact(ContactModel contact) async {
    final updatedName = _nameController.text;
    final updatedPhone = _phoneController.text;

    final updatedContact = ContactModel(
      id: contact.id,
      name: updatedName,
      phone: updatedPhone,
    );

    final rowsAffected = await _databaseHelper.updateContact(updatedContact);

    if (rowsAffected > 0) {
      _nameController.clear();
      _phoneController.clear();
      _fetchContacts();
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content: Text('Ocorreu um erro ao atualizar o contato.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  void _deleteContact(ContactModel contact) async {
    final confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar exclusão'),
        content: Text('Deseja excluir este contato?'),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: Text('Excluir'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirm) {
      final rowsAffected = await _databaseHelper.deleteContact(contact.id);

      if (rowsAffected > 0) {
        _fetchContacts();
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Erro'),
            content: Text('Ocorreu um erro ao excluir o contato.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    }
  }

  void _editContact(ContactModel contact) {
    _nameController.text = contact.name;
    _phoneController.text = contact.phone;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar Contato'),
        content: Form(
          key: _formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite o nome do contato.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Telefone',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite o telefone do contato.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              _nameController.clear();
              _phoneController.clear();
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Salvar'),
            onPressed: () {
              if (_formkey.currentState!.validate()) {
                _updateContact(contact);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contact = _contacts[index];
          return ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.phone),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteContact(contact),
            ),
            onTap: () => _editContact(contact),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Criar Contato'),
              content: Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite o nome do contato.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Telefone',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite o telefone do contato.';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    _nameController.clear();
                    _phoneController.clear();
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text('Criar'),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _createContact();
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
