import 'package:flutter/material.dart';

class MannerTemperature extends StatelessWidget {
  double? mannerTemp;
  int? level;
  // 레벨별 컬러
  final List<Color> tempColors = [
    Color(0xff072038),
    Color(0xff0d3a65),
    Color(0xff186ec0),
    Color(0xff37b24d),
    Color(0xffffad13),
    Color(0xfff76707),
  ];

  MannerTemperature({Key? key, this.mannerTemp}) {
    _calcTempLevel();
  }

  void _calcTempLevel() {
    if (mannerTemp! <= 20) {
      level = 0;
    } else if (mannerTemp! > 20 && mannerTemp! <= 32) {
      level = 1;
    } else if (mannerTemp! > 32 && mannerTemp! <= 36.5) {
      level = 2;
    } else if (mannerTemp! > 36.5 && mannerTemp! <= 40) {
      level = 3;
    } else if (mannerTemp! > 40 && mannerTemp! <= 50) {
      level = 4;
    } else if (mannerTemp! > 50) {
      level = 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              _makeTempLabelAndBar(),
              // 이모티콘 이미지
              Container(
                margin: EdgeInsets.only(left: 5),
                width: 29,
                child: Image.asset("assets/images/level-$level.jpg"),
              ),
            ],
          ),
          SizedBox(height: 7),
          Text(
            "매너온도",
            style: TextStyle(
              // 밑줄 생성
              decoration: TextDecoration.underline,
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  _makeTempLabelAndBar() {
    return Container(
      width: 66,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${mannerTemp}°C",
            style: TextStyle(
              color: tempColors[level!],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 6,
              color: Colors.black.withOpacity(0.1),
              child: Row(
                children: [
                  Container(
                    height: 6,
                    width: 65 / 99 * mannerTemp!,
                    color: tempColors[level!],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
