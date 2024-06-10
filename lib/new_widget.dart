import 'package:flutter/material.dart';
import 'full_screen_image.dart';

class NewWidget extends StatelessWidget {
  const NewWidget({super.key});

  void _navigateToFullScreenImage(BuildContext context, String imageAsset) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullScreenImage(imageAsset: imageAsset),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // NewWidget 페이지의 배경 이미지 설정
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/page3.png'),
                fit: BoxFit.cover, // 이미지가 화면 전체를 덮도록 설정
              ),
            ),
          ),
          // 버튼들 추가
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _navigateToFullScreenImage(context, 'assets/c1.png'),
                  child: Container(
                    width: 360, // 가로 길이 조절
                    height: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/button3-1.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2), // 버튼 간 간격
                GestureDetector(
                  onTap: () => _navigateToFullScreenImage(context, 'assets/c4.png'),
                  child: Container(
                    width: 360, // 가로 길이 조절
                    height: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/button3-2.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2), // 버튼 간 간격
                GestureDetector(
                  onTap: () => _navigateToFullScreenImage(context, 'assets/c5.png'),
                  child: Container(
                    width: 360, // 가로 길이 조절
                    height: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/button3-3.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2), // 버튼 간 간격
                GestureDetector(
                  onTap: () => _navigateToFullScreenImage(context, 'assets/c3.png'),
                  child: Container(
                    width: 360, // 가로 길이 조절
                    height: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/button3-4.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2), // 버튼 간 간격
                GestureDetector(
                  onTap: () => _navigateToFullScreenImage(context, 'assets/c2.png'),
                  child: Container(
                    width: 360, // 가로 길이 조절
                    height: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/button3-5.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
