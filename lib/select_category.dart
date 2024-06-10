import 'package:flutter/material.dart';
import 'dart:typed_data';

class SelectCategoryPage extends StatefulWidget {
  final Uint8List imageData;

  const SelectCategoryPage({super.key, required this.imageData});

  @override
  _SelectCategoryPageState createState() => _SelectCategoryPageState();
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {
  String? _selectedCategory;
  final TextEditingController _controller = TextEditingController();

  void _saveData() {
    if (_selectedCategory != null && _controller.text.isNotEmpty) {
      Navigator.of(context).pop({
        'category': _selectedCategory,
        'text': _controller.text,
        'imageData': widget.imageData,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/page2_2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Image.memory(
                  widget.imageData,
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                const Text(
                  '2024.05.30',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: DropdownButton<String>(
                      value: _selectedCategory,
                      hint: const Text(
                        'Select a Category',
                        style: TextStyle(color: Colors.blue),
                      ),
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
                      underline: const SizedBox(),
                      dropdownColor: Colors.black,
                      items: [
                        'Soups and Stews',
                        'Stir-fried Dishes',
                        'Noodles',
                        'Grilled Dishes',
                        'Rice Dishes',
                        'Korean Pancake',
                        'Desserts and Snacks',
                        'Alcoholic Beverage'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'ex. I want to try it again next time. It tasted sweet',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _saveData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  ),
                  child: const Text('save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


