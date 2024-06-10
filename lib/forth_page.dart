import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

import 'full_screen_image.dart';
import 'select_category.dart';
import 'food_record.dart';

class FourthPage extends StatelessWidget {
  const FourthPage({super.key});

  void _navigateToFullScreenImage(BuildContext context, String imageAsset) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullScreenImage(imageAsset: imageAsset),
      ),
    );
  }

  void _navigateToCategory(BuildContext context, String category) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FoodRecordPage(category: category),
      ),
    );
  }

  Future<void> _openCamera(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final Uint8List imageData = await image.readAsBytes();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SelectCategoryPage(imageData: imageData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // FourthPage 페이지의 배경 이미지 설정
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/page4.png'),
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
                  onTap: () => _navigateToCategory(context, 'Soups and Stews'),
                  child: Container(
                    width: 360, // 가로 길이 조절
                    height: 70, // 동일한 높이 설정
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bt4_1.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5), // 버튼 간 간격
                GestureDetector(
                  onTap: () => _navigateToCategory(context, 'Stir-fried Dishes'),
                  child: Container(
                    width: 360, // 가로 길이 조절
                    height: 70, // 동일한 높이 설정
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bt4_2.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5), // 버튼 간 간격
                GestureDetector(
                  onTap: () => _navigateToCategory(context, 'Noodles'),
                  child: Container(
                    width: 360, // 가로 길이 조절
                    height: 70, // 동일한 높이 설정
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bt4_3.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5), // 버튼 간 간격
                GestureDetector(
                  onTap: () => _navigateToCategory(context, 'Grilled Dishes'),
                  child: Container(
                    width: 360, // 가로 길이 조절
                    height: 70, // 동일한 높이 설정
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bt4_4.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5), // 버튼 간 간격
                GestureDetector(
                  onTap: () => _navigateToCategory(context, 'Rice Dishes'),
                  child: Container(
                    width: 360, // 가로 길이 조절
                    height: 70, // 동일한 높이 설정
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bt4_5.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5), // 버튼 간 간격
                GestureDetector(
                  onTap: () => _navigateToCategory(context, 'Korean Pancake'),
                  child: Container(
                    width: 360, // 가로 길이 조절
                    height: 70, // 동일한 높이 설정
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bt4_6.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5), // 버튼 간 간격
                GestureDetector(
                  onTap: () => _navigateToCategory(context, 'Desserts and Snacks'),
                  child: Container(
                    width: 360, // 가로 길이 조절
                    height: 70, // 동일한 높이 설정
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bt4_7.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5), // 버튼 간 간격
                GestureDetector(
                  onTap: () => _navigateToCategory(context, 'Alcoholic Beverage'),
                  child: Container(
                    width: 360, // 가로 길이 조절
                    height: 70, // 동일한 높이 설정
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bt4_8.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5), // 새로운 버튼 간 간격
                GestureDetector(
                  onTap: () => _openCamera(context),
                  child: Container(
                    width: 360, // 가로 길이 조절
                    height: 70, // 동일한 높이 설정
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/camera.png'),
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
