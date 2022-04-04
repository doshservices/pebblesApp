import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 2,
                  child: Center(
                      child: Image.asset(
                    'assets/images/pebblestext.png',
                    width: MediaQuery.of(context).size.width / 1.5,
                    fit: BoxFit.contain,
                  ))),
            ],
          )
        ],
      ),
    );
  }
}
