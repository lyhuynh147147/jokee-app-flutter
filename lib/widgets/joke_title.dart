import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class JokeTitle extends StatelessWidget {
  const JokeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorUtil.green,
      width: double.infinity,
      child: Column(
        children: const [
          /// Spacing
          SizedBox(height: 40),

          /// Title
          Text(
            'A joke a day keeps the doctor away',
            style: TextStyle(
              fontSize: 18,
              color: ColorUtil.white,
            ),
            textAlign: TextAlign.center,
          ),

          /// Spacing
          SizedBox(height: 20),

          /// Title
          Text(
            'If you joke wrong way, your teeth have to pay. (Serious)',
            style: TextStyle(
              fontSize: 12,
              color: ColorUtil.white,
            ),
            textAlign: TextAlign.center,
          ),

          /// Spacing
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
