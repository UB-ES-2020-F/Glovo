import 'package:customerapp/styles/Komet.dart';
import 'package:customerapp/styles/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SingleMessageDialog extends StatelessWidget {
  final String message;
  SingleMessageDialog(this.message);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        children: [
          Container(
              constraints: BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment(1, 1),
                      child: IconButton(
                        color: Color(0xFF6E6E6E),
                        icon: Icon(Icons.clear),
                        iconSize: 40,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )),
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      message,
                      style: registerToKometTextStyle,
                    ),
                  ),
                  Padding(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Okay"),
                      style: greenButtonStyle,
                    ),
                    padding: EdgeInsets.all(20),
                  )
                ],
              ))
        ]);
  }
}

showLoaderDialog(BuildContext context) {
  Dialog loading = Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child:
          Padding(padding: EdgeInsets.all(20.0), child: CircularLoaderKomet()));
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return loading;
    },
  );
}

class CircularLoaderKomet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 80,
      height: 80,
      child: CircularProgressIndicator(
        backgroundColor: kommetDistinctiveGreen,
        strokeWidth: 7,
      ),
    ));
  }
}
