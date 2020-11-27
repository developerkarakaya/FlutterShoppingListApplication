import 'package:flutter/material.dart';

class ItemDialog extends StatefulWidget {
  @override
  _ItemDialogState createState() => _ItemDialogState();
}

class _ItemDialogState extends State<ItemDialog> {
  final _formKey = GlobalKey<FormState>();
  String _itemName;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Alışveriş Listesine Ekleyin"),
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  maxLength: 50,
                  autofocus: true,
                  onSaved: (value) {
                    _itemName = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Boş Geçemezsiniz";
                    }
                    if (value.length > 50) {
                      return "50 Karakterden fazla giremezsiniz";
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                onPressed: _formSave,
                child: Text("Listeye Ekle"),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
              )
            ],
          ),
        )
      ],
    );
  }

  void _formSave() {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      Navigator.pop(context, _itemName);
    } else {}
  }
}
