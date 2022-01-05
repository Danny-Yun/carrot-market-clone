import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱바 뒤쪽으로 겹치게
      extendBodyBehindAppBar: true,
      appBar: _appbar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appbar() {
    return AppBar(
      // 앱바 투명색으로 안 보이게
      backgroundColor: Colors.transparent,
      elevation: 0,
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

  Widget _body() {
    return Container(
      // Hero위젯을 이용해서 페이지 이동시 애니메이션 효과 적용
      child: Hero(
        tag: widget.data['cid']!,
        child: Image.asset(
          widget.data['image']!,
          // 미디어쿼리 사이즈에 맞게
          width: size!.width,
          fit: BoxFit.fill,
        ),
      ),
      // child: Center(
      //  child: Center(child: Text(widget.data['title']!)),
      // ),
    );
  }
}
