import 'package:carrot_market_clone/repository/ContentsRepository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String currentLocation = 'bansong';
  late ContentsRepository contentsRepository;

  final Map<String, String> locationTypeToString = {
    "bansong": "반송동",
    "osan": "오산동",
    "seokwoo": "석우동",
  };

  @override
  void initState() {
    super.initState();
    // currentLocation = 'bansong';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    contentsRepository = ContentsRepository();
  }

  final oCcy = new NumberFormat("#,###", "ko_KR");
  // 금액을 원 단위로, 1000씩 끊어서 보이게끔
  String priceStringToWon(String priceString) {
    // 무료나눔일 경우 변환하지 않고 리턴
    if (priceString == "무료나눔") return priceString;
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

  _loadContents() {
    return contentsRepository.loadContentsFromLocation(currentLocation);
  }

  // 바디 위젯
  Widget _body() {
    return FutureBuilder(
      future: _loadContents(),
      builder: (context, dynamic snapshot) {
        // 데이터가 호출될때까지 인디케이터 띄우기
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("데이터 오류"));
        }
        return _dataList(snapshot.data);
      },
    );
  }

  _dataList(List<Map<String, String>> datas) {
    // print(datas);
    if (datas.isEmpty == true) {
      return Center(child: Text("해당 지역은 요청하신 정보가 존재하지 않습니다."));
    }
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
