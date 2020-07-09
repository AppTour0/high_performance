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
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey[400],
        height: 0,
      ),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return Center(
            child: Column(
          children: <Widget>[
            ListTile(
              title: Text(list[index].title),
              subtitle: Text(list[index].subtitle),
              onTap: () {
                route != null
                    ? Modular.to
                        .pushNamed(route, arguments: list[index].id)
                        .then((value) => tapAction)
                    : null;
              },
            ),
          ],
        ));
      },
    );
  }
}
