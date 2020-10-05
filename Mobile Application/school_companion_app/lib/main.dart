import 'package:flutter/material.dart';
import './screens/login.dart';
import './components/login/backgroundpainter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RenderFlex(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
    );
  }
}

class RenderFlex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomPaint(
      painter: BackgroundPainter(),
      child: Center(
        child: SingleChildScrollView(
          child: LoginComponent(),
        ),
      ),
    ));
  }
}
