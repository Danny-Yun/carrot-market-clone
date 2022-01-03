import 'package:carrot_market_clone/screen/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late int _currentPageIndex;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = 0;
  }

  // 빌드 위젯
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: _bnb(),
    );
  }

  // 바디 위젯
  Widget _body() {
    switch (_currentPageIndex) {
      case 0:
        return Home();
      case 1:
        return Container();
      case 2:
        return Container();
      case 3:
        return Container();
      case 4:
        return Container();
    }
    return Container();
  }

  // 네비게이션바 위젯
  Widget _bnb() {
    return BottomNavigationBar(
      // 애니메이션 효과 제거
      type: BottomNavigationBarType.fixed,
      // 선택시 글자가 안커지게 고정
      selectedFontSize: 12,
      onTap: (int index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
      currentIndex: _currentPageIndex,
      items: [
        _bottomNavigationBarItem('home', '홈'),
        _bottomNavigationBarItem('notes', '동네생활'),
        _bottomNavigationBarItem('location', '내 근처'),
        _bottomNavigationBarItem('chat', '채팅'),
        _bottomNavigationBarItem('user', '나의 당근'),
      ],
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      String iconName, String label) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: SvgPicture.asset("assets/svg/${iconName}_off.svg", width: 22),
      ),

      // 선택된 네비게이션 아이콘 fas(색칠)로 변환할 수 있게
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: SvgPicture.asset("assets/svg/${iconName}_on.svg",
            width: 22, color: Colors.orange),
      ),
      label: label,
    );
  }
}
