import 'package:capstone/style/app_style.dart';
import 'package:flutter/material.dart';

class HorizontalListWithImage extends StatelessWidget {
  final List<String> options;
  final Function(String) onOptionSelected;

  HorizontalListWithImage({
    required this.options,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: options.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () => onOptionSelected(options[index]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/${options[index]}.jpg',
                    height: 50,
                    width: 50,
                  ),
                ),
                Text(
                  options[index],
                  style: TextStyle(color: AppStyle.mainColor),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
