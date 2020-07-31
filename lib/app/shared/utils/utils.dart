import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class Utils {
  Future<void> alertDioalog(
    BuildContext context,
    String title,
    String value,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(value),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<ConfirmAction> asyncConfirmDialog({
    BuildContext context,
    String title,
    String value,
    Color color = Colors.black,
  }) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: color),
          ),
          content: Text(value),
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('Confirmar'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }

  static Future showDialogTeste(BuildContext context, countries) async {
    String _code;

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Tipo de Passeio'),
          actions: <Widget>[
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop('Cancelar');
              },
              child: Text('Cancelar'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop(_code);
              },
              child: Text('Confirmar'),
            ),
          ],
          content: SingleChildScrollView(
            child: Material(
              child: MyDialogContent(countries: countries, code: _code),
            ),
          ),
        );
      },
      barrierDismissible: false,
    );
  }

  static orderStatus(String status) {
    switch (status.toLowerCase()) {
      case "processing":
        return "Processando";
        break;
      case "authorized":
        return "Autorizado";
        break;
      case "paid":
        return "Pago";
        break;
      case "refunded":
        return "Estornado";
        break;
      case "waiting_payment":
        return "Aguardando Pagamento";
        break;
      case "pending_refund":
        return "Extorno Pendente";
        break;
      case "refused":
        return "Rejeitado";
        break;
    }
  }

  static cardBrandImg(String type) {
    switch (type.toLowerCase()) {
      case "visa":
        return 'assets/img/visa.png';
        break;
      case "mastercard":
        return 'assets/img/master.png';
        break;
      case "amex":
        return 'assets/img/amex.png';
        break;
      case "elo":
        return 'assets/img/elo.png';
        break;
      case "hipercard":
        return 'assets/img/hipercard.png';
        break;
    }
  }

  List<dynamic> typeCoupon = ["promo", "unique"];

  typeTextCoupon(String type) {
    switch (type.toLowerCase()) {
      case "promo":
        return 'Promocional';
        break;
      case "unique":
        return 'Único';
        break;
    }
  }

  static progressDialog(context) {
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      //isDismissible: false,
    );
    pr.style(
      message: '   Aguarde...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    return pr;
  }

  static dateFormatDB(String date) {
    var day = date.substring(0, 2);
    var month = date.substring(3, 5);
    var year = date.substring(6);

    String dateFormat = year + "-" + month + "-" + day;
    return dateFormat;
  }

  static launchEmail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  static pricePagarme(String value) {
    int valueLength = 0;
    String last = "";
    String begin = "";
    String tempValue = "";
    num returnValue = 0.0;

    valueLength = value.toString().length;
    last = value.toString().substring(valueLength - 2);
    begin = value.toString().substring(0, valueLength - 2);
    tempValue = begin + "." + last;
    returnValue = num.tryParse(tempValue);

    return returnValue;
  }

  flushBarDanger({
    @required BuildContext context,
    @required String title,
    @required String description,
    Duration duration,
    bool positionBottom = false,
  }) {
    if (description.toLowerCase().contains("terminated") ||
        description.toLowerCase().contains("closed")) {
      description = "Problema de conexão.\nPor favor, tente novamente.";
    }
    return Flushbar(
      title: title,
      message: description,
      duration: duration == null ? Duration(seconds: 8) : duration,
      flushbarPosition:
          !positionBottom ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
      leftBarIndicatorColor: Colors.red,
      isDismissible: false,
      shouldIconPulse: false,
      icon: Icon(
        FontAwesomeIcons.times,
        color: Colors.red,
      ),
      //margin: EdgeInsets.all(8),
      //borderRadius: 8,
      backgroundColor: Colors.black.withOpacity(0.9),
    )..show(context);
  }

  flushBarSuccess({
    @required BuildContext context,
    @required String title,
    @required String description,
    Duration duration,
    bool positionBottom = false,
  }) {
    return Flushbar(
      title: title,
      message: description,
      duration: duration == null ? Duration(seconds: 8) : duration,
      flushbarPosition:
          !positionBottom ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
      leftBarIndicatorColor: Colors.green,
      isDismissible: false,
      shouldIconPulse: false,
      icon: Icon(
        FontAwesomeIcons.checkCircle,
        color: Colors.green,
      ),
      //margin: EdgeInsets.all(8),
      //borderRadius: 8,
      backgroundColor: Colors.black.withOpacity(0.9),
    )..show(context);
  }

  flushBarWarning({
    @required BuildContext context,
    @required String title,
    @required String description,
    Duration duration,
    bool positionBottom = false,
  }) {
    return Flushbar(
      title: title,
      message: description,
      duration: duration == null ? Duration(seconds: 8) : duration,
      flushbarPosition:
          !positionBottom ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
      leftBarIndicatorColor: Colors.orange,
      isDismissible: false,
      shouldIconPulse: false,
      icon: Icon(
        FontAwesomeIcons.exclamationTriangle,
        color: Colors.orange,
      ),
      //margin: EdgeInsets.all(8),
      //borderRadius: 8,
      backgroundColor: Colors.black.withOpacity(0.9),
    )..show(context);
  }

  parsePriceToDouble(String price) {
    // esse substring é pq o valor que vem na função tem um R$ antes do número
    String value = price.substring(3);
    double finalValue = double.tryParse(value);
    return finalValue;
  }

  parsePercentToDouble(String price) {
    String value = price.substring(0, price.length - 1);
    double finalValue = double.tryParse(value);
    return finalValue;
  }
}

class MyDialogContent extends StatefulWidget {
  MyDialogContent({
    Key key,
    this.countries,
    this.code,
  }) : super(key: key);

  final List<Map> countries;
  String code;

  @override
  _MyDialogContentState createState() => new _MyDialogContentState();
}

class _MyDialogContentState extends State<MyDialogContent> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  _getContent() {
    if (widget.countries.length == 0) {
      return new Container();
    }
    if (widget.countries.length > 0) {
      widget.code = (widget.countries[_selectedIndex]["code"]);
    }

    return new Column(
        children: new List<RadioListTile<int>>.generate(widget.countries.length,
            (int index) {
      return new RadioListTile<int>(
        value: index,
        groupValue: _selectedIndex,
        title: new Text(widget.countries[index]["description"]),
        onChanged: (int value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }
}

/* HttpClient client = new HttpClient();
        await client.headUrl(Uri.parse(url))
              .then((HttpClientRequest request) {
                return request.close();
              })
              .then((HttpClientResponse response) async {
               teste = response;
                print(teste);
              }); */
