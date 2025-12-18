import 'package:flutter/material.dart';

class AddPhotoContent extends StatelessWidget {
  const AddPhotoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.add_a_photo_outlined, size: 32, color: Colors.blue),
          SizedBox(height: 8),
          Text(
            'Adicionar Foto',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
