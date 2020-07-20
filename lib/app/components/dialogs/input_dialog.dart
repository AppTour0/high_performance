import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class InputDialog {
  Future showInput({
    @required BuildContext context,
    @required TextEditingController textEditing,
    @required Function changedAction(String v),
    @required dynamic tapAction(),
  }) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Adicionar'),
            content: TextFormField(
              controller: textEditing,
              onChanged: (v) {
                changedAction(v);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'escreva...',
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Modular.to.pop();
                  textEditing.text = "";
                },
                child: Text('Cancelar'),
              ),
              FlatButton(
                onPressed: () {
                  tapAction();
                  Modular.to.pop();
                  textEditing.text = "";
                },
                child: Text('Adicionar'),
              ),
            ],
          );
        });
  }
}
