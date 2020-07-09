import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseModal {
  Future choose({
    @required BuildContext context,
    @required List<Map<String, dynamic>> list,
    @required TextEditingController idEditing,
    @required TextEditingController textEditing,
  }) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context) {
          return Container(
              height: 300,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    /* ListTile(
              leading: Icon(Icons.add),
              title: Text("Novo Cartão"),
              onTap: () async {
              },
            ), */

                    ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: list == null ? 0 : list.length,
                        itemBuilder: (BuildContext context, int index) {
                          //String icon = Utils.cardBrandImg(data[index].brand);

                          return ListTile(
                            /* leading: Image.asset(
                      icon,
                      height: 26,
                      width: 40,
                      fit: BoxFit.cover,
                    ), */
                            title: Text(list[index]["title"]),
                            onTap: () {
                              textEditing.text = list[index]["title"];
                              idEditing.text = list[index]["id"].toString();
                              Navigator.pop(context);
                            },
                          );
                        })
                  ],
                ),
              ));
        });
  }
}
