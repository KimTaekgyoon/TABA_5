import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _openCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      // 이미지를 선택한 후에 추가 작업을 여기에 작성할 수 있습니다.
      print('Image selected: ${image.path}');
    } else {
      print('No image selected.');
    }
  }

  Future<void> _openGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // 이미지를 선택한 후에 추가 작업을 여기에 작성할 수 있습니다.
      print('Image selected: ${image.path}');
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 페이지 배경 이미지 설정
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/page2_2.png'),
                fit: BoxFit.cover, // 이미지가 화면 전체를 덮도록 설정
              ),
            ),
          ),
          // 카메라 버튼
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _openCamera,
                  child: Image.asset(
                    'assets/camera.png',
                    width: 400,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 2), // 버튼 간 간격을 10으로 줄임
                GestureDetector(
                  onTap: _openGallery,
                  child: Image.asset(
                    'assets/gallery.png',
                    width: 400,
                    height: 200,
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
