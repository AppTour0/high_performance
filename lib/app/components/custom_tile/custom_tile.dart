import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:high_performance/app/components/custom_tile/tile_model.dart';

class CustomTile extends StatelessWidget {
  final List<TileModel> list;
  final String route;
  final Future<dynamic> tapAction;

  CustomTile({Key key, @required this.list, this.route, this.tapAction})
      : assert(list != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      /* separatorBuilder: (context, index) => Divider(
        color: Colors.grey[400],
        height: 0,
      ), */
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.cyan[100],
            ),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: list[index].title,
                  subtitle: Column(
                    children: <Widget>[
                      for (var item in list[index].subtitle) item
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    route != null
                        ? Modular.to
                            .pushNamed(route, arguments: list[index].id)
                            .then((value) => tapAction)
                        : null;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
