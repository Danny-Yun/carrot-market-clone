import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, String>> datas = [];
  String currentLocation = 'bansong';
  final Map<String, String> locationTypeToString = {
    "bansong": "반송동",
    "osan": "오산동",
    "seokwoo": "석우동",
  };

  @override
  void initState() {
    super.initState();
    datas = [
      {
        "image": "assets/images/ara-1.jpg",
        "title": "네메시스 축구화 275",
        "location": "경기 화성시 반송동",
        "price": "30000",
        "likes": "2"
      },
      {
        "image": "assets/images/ara-2.jpg",
        "title": "LA갈비 5kg 팔아요~",
        "location": "경기 화성시 반송동",
        "price": "100000",
        "likes": "6"
      },
      {
        "image": "assets/images/ara-3.jpg",
        "title": "치약 팝니다",
        "location": "경기 화성시 반송동",
        "price": "5000",
        "likes": "0"
      },
      {
        "image": "assets/images/ara-4.jpg",
        "title": "맥북프로16인치 터치바 스페이스그레이",
        "location": "경기 화성시 반송동",
        "price": "2500000",
        "likes": "3"
      },
      {
        "image": "assets/images/ara-5.jpg",
        "title": "디월트존기임팩",
        "location": "경기 화성시 반송동",
        "price": "150000",
        "likes": "1"
      },
      {
        "image": "assets/images/ara-6.jpg",
        "title": "갤럭시S10",
        "location": "경기 화성시 반송동",
        "price": "270000",
        "likes": "4"
      },
      {
        "image": "assets/images/ara-7.jpg",
        "title": "선반",
        "location": "경기 화성시 반송동",
        "price": "15000",
        "likes": "2"
      },
      {
        "image": "assets/images/ara-8.jpg",
        "title": "냉장 쇼케이스",
        "location": "경기 화성시 반송동",
        "price": "80000",
        "likes": "1"
      },
      {
        "image": "assets/images/ara-9.jpg",
        "title": "미니 냉장고",
        "location": "경기 화성시 반송동",
        "price": "30000",
        "likes": "3"
      },
      {
        "image": "assets/images/ara-10.jpg",
        "title": "멜킨스 풀업 턱걸이 판매합니다",
        "location": "경기 화성시 반송동",
        "price": "50000",
        "likes": "10"
      },
    ];
  }

  final oCcy = new NumberFormat("#,###", "ko_KR");
  // 금액을 원 단위로, 1000씩 끊어서 보이게끔
  String priceStringToWon(String priceString) {
    return "${oCcy.format(int.parse(priceString))}원";
  }

  // 빌드 위젯
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
    );
  }

  // 앱바 위젯
  PreferredSizeWidget _appbar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      title: GestureDetector(
        onTap: () {
          print("location click");
        },
        child: PopupMenuButton<String>(
          // 사용자가 선택했을 때
          onSelected: (String where) {
            print(where);
            setState(() {
              currentLocation = where;
              locationTypeToString[currentLocation];
            });
          },
          // select 지역 리스트 생성
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(value: "bansong", child: Text("반송동")),
              PopupMenuItem(value: "osan", child: Text("오산동")),
              PopupMenuItem(value: "seokwoo", child: Text("석우동")),
            ];
          },
          shape: ShapeBorder.lerp(
            // select 리스트의 모양을 둥글게
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            1,
          ),
          // select 리스트의 위치를 이동
          offset: Offset(-10, 30),
          child: Row(
            children: [
              Text(
                '${locationTypeToString[currentLocation]}',
                style: TextStyle(color: Colors.black87),
              ),
              Icon(Icons.arrow_drop_down, color: Colors.black),
            ],
          ),
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

  // 바디 위젯
  Widget _body() {
    return ListView.separated(
      itemBuilder: (context, index) {
        String imageUrl = datas[index]["image"]!;
        String titleUrl = datas[index]["title"]!;
        String locationUrl = datas[index]["location"]!;
        String priceUrl = priceStringToWon(datas[index]["price"]!);
        String likesUrl = datas[index]["likes"]!;

        return Container(
          padding: EdgeInsets.all(13),
          child: Row(
            children: [
              // Clipper - 깎는 도구로서 특정 위젯(주로 이미지)을 원하는 형태로 만든다.
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.asset(
                  imageUrl,
                  height: 120,
                  width: 120,
                ),
              ),
              // 영역을 꽉 채워주고 싶을땐 Expanded 위젯으로 감싸서 활용
              // 단 아래  height:120 처럼 팽창시킬 기준을 정해줘야 한다.
              Expanded(
                // 텍스트 컨테이너
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 120,
                  // color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 13.0),
                        child: Text(
                          titleUrl,
                          style: TextStyle(fontSize: 19),
                          // 글자 수가 초과되면 ... 으로 처리
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        locationUrl,
                        style: TextStyle(
                            fontSize: 15, color: Colors.black.withOpacity(0.4)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        priceUrl,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        child: Container(
                          // color: Colors.blue,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/heart_off.svg",
                                width: 15,
                                height: 15,
                                color: Colors.red,
                              ),
                              SizedBox(width: 3),
                              Text(
                                likesUrl,
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 13),
          child: Divider(
            height: 2,
            thickness: 2,
            color: Colors.black.withOpacity(0.1),
          ),
        );
      },
      itemCount: 10,
    );
  }
}
