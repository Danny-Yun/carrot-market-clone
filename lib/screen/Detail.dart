import 'package:carrot_market_clone/components/manner_temperature.dart';
import 'package:carrot_market_clone/repository/ContentsRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class DetailContentView extends StatefulWidget {
  late Map<String, String> data;

  DetailContentView(data) {
    this.data = data;
  }

  @override
  _DetailContentViewState createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView> {
  Size? size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 미디어쿼리를 통해 사용자 디바이스에 맞는 사이즈 지정
    size = MediaQuery.of(context).size;
  }

  final oCcy = new NumberFormat("#,###", "ko_KR");
  // 금액을 원 단위로, 1000씩 끊어서 보이게끔
  String priceStringToWon(String priceString) {
    // 무료나눔일 경우 변환하지 않고 리턴
    if (priceString == "무료나눔") return priceString;
    return "${oCcy.format(int.parse(priceString))}원";
  }

  // 빌드
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱바 뒤쪽으로 겹치게
      extendBodyBehindAppBar: true,
      appBar: _appbar(),
      body: _body(),
      bottomNavigationBar: _buttombar(),
    );
  }

  // 앱바
  PreferredSizeWidget _appbar() {
    return AppBar(
      // 앱바 배경이 사라지게
      backgroundColor: Colors.white.withAlpha(0),
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.share),
          color: Colors.white,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert),
          color: Colors.white,
        ),
      ],
    );
  }

  // 바디
  Widget _body() {
    return CustomScrollView(slivers: [
      SliverList(
          delegate: SliverChildListDelegate(
        [
          // 제품사진 - Hero위젯을 이용해서 페이지 이동시 사진에 애니메이션 효과 적용
          Hero(
            tag: widget.data['cid']!,
            child: Image.asset(
              widget.data['image']!,
              // 미디어쿼리 사이즈에 맞게
              width: size!.width,
              fit: BoxFit.fill,
            ),
          ),
          // 판매자 간단정보
          _sellerSimpleInfo(),
          _divider(),
          // 제품 상세정보
          _contentDetail(),
          _divider(),
          // 다른 판매 상품 목록
          _otherItems(),
        ],
      )),
      SliverPadding(
        padding: const EdgeInsets.all(20),
        // SliverGrid를 통해 갤러리처럼 나누기
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15),
          delegate: SliverChildListDelegate(List.generate(10, (index) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      color: Colors.grey,
                      height: 110,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("상품 제목", style: TextStyle(fontSize: 14)),
                  SizedBox(height: 3),
                  Text("금액",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            );
          }).toList()),
        ),
      ),
    ]);
  }

  // 판매자 간단정보
  Widget _sellerSimpleInfo() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: Image.asset("assets/images/user.png").image,
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '리우디우',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text("화성시 반송동"),
                ],
              ),
            ],
          ),
          MannerTemperature(mannerTemp: 37.5),
        ],
      ),
    );
  }

  // 상품 상세정보
  Widget _contentDetail() {
    return Container(
      padding: EdgeInsets.all(19),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.data['title']!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            '운동/기구 ∙ 19시간 전',
            style: TextStyle(
              color: Colors.black.withOpacity(0.45),
              fontSize: 14,
            ),
          ),
          SizedBox(height: 15),
          Text(
            "선물받은 새상품이고\n상품은 꺼내보기만 했습니다\n거래는 직거래만 합니다.",
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          SizedBox(height: 15),
          Text(
            "채팅 3 ∙ 관심 17 ∙ 조회 305",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // 다른 판매 상품
  Widget _otherItems() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 19),
      margin: EdgeInsets.only(top: 19),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '리우디우님의 판매 상품',
            style: TextStyle(
              fontSize: 16.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '모두보기',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // 구분선
  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      child: Divider(
          height: 10, thickness: 1, color: Colors.black.withOpacity(0.1)),
    );
  }

  // 바텀
  Widget _buttombar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: size!.width,
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  "assets/svg/heart_off.svg",
                  width: 24,
                  height: 24,
                ),
              ),
              SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${priceStringToWon(widget.data['price']!)}',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    '가격 제안하기',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              '채팅으로 거래하기',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.orange[600],
            ),
          ),
        ],
      ),
    );
  }
}