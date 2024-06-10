import 'package:flutter/material.dart';
import 'camera.dart';
import 'new_widget.dart';
import 'forth_page.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  void _navigateToCameraPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CameraPage(),
      ),
    );
  }

  void _navigateToNewWidget(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NewWidget(),
      ),
    );
  }

  void _navigateToFourthPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const FourthPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // 두 번째 페이지 배경 이미지 설정
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/page2_2.png'),
                fit: BoxFit.cover, // 이미지가 화면 전체를 덮도록 설정
              ),
            ),
          ),
          // 첫 번째 버튼 - 왼쪽 절반 중앙
          Positioned(
            left: screenWidth / 4 - 85, // 화면의 1/4에서 버튼 너비의 절반을 뺌
            top: 229,
            width: 200,
            height: 290,
            child: GestureDetector(
              onTap: _navigateToCameraPage,
              child: Image.asset('assets/button1.png'),
            ),
          ),
          // 두 번째 버튼 - 오른쪽 절반 중앙
          Positioned(
            left: screenWidth * 3 / 4 - 115, // 화면의 3/4에서 버튼 너비의 절반을 뺌
            top: 229,
            width: 200,
            height: 290, // 버튼 2의 height를 버튼 1과 동일하게 280으로 설정
            child: GestureDetector(
              onTap: _navigateToCameraPage,
              child: Image.asset('assets/button2.png'),
            ),
          ),
          // 세 번째 버튼 - 전체 화면 중앙
          Positioned(
            left: screenWidth / 2 - (screenWidth - (screenWidth / 4 - 85) * 2) * 0.5, // 화면의 중앙에서 버튼 너비의 절반을 뺌
            top: 539,
            width: screenWidth - (screenWidth / 4 - 85) * 2,
            height: 52,
            child: GestureDetector(
              onTap: () => _navigateToNewWidget(context),
              child: Image.asset('assets/button3.png'),
            ),
          ),
          // 네 번째 버튼 - 전체 화면 중앙, 세 번째 버튼 아래
          Positioned(
            left: screenWidth / 2 - (screenWidth - (screenWidth / 4 - 85) * 2) * 0.5, // 화면의 중앙에서 버튼 너비의 절반을 뺌
            top: 600, // 기존 610에서 71px 아래로 이동
            width: screenWidth - (screenWidth / 4 - 85) * 2,
            height: 52,
            child: GestureDetector(
              onTap: () => _navigateToFourthPage(context),
              child: Image.asset('assets/button4.png'),
            ),
          ),
        ],
      ),
    );
  }
}
