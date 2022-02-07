import 'package:flutter/material.dart';

class ChatAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
            ),
            color: Colors.grey.withOpacity(0.2)),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(),
            ),
            Divider(
              color: Colors.grey.withOpacity(0.6),
              thickness: 2,
            ),
            TextFormField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                    left: 20,
                  ),
                  suffixIcon: Icon(
                    Icons.send,
                    color: Theme.of(context).accentColor,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
