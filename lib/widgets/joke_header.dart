import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class JokeHeader extends StatelessWidget {
  const JokeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: Row(
        children: [
          /// Logo
          Image.asset(
            'assets/images/logo.png',
            height: 50,
          ),
          const Spacer(),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                'Handicrafted by',
                style: TextStyle(
                  color: ColorUtil.grey,
                  fontSize: 10,
                ),
              ),

              /// Name
              Text(
                'Jim HLS',
                style: TextStyle(
                  color: ColorUtil.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          /// Spacing
          const SizedBox(width: 2),

          /// Avatar
          CircleAvatar(
            radius: 20,
            child: Image.asset(
              'assets/images/avatar.png',
            ),
          ),
        ],
      ),
    );
  }
}