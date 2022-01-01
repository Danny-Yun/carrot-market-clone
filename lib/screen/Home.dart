import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Container(),
      bottomNavigationBar: Container(),
    );
  }

  PreferredSizeWidget _appbar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      title: GestureDetector(
        onTap: () {
          print("location click");
        },
        child: Row(
          children: [
            Text(
              '반송동',
              style: TextStyle(color: Colors.black87),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.black),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
          color: Colors.black,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.tune),
          color: Colors.black,
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            "assets/svg/bell.svg",
            width: 22,
          ),
        ),
      ],
    );
  }
}
