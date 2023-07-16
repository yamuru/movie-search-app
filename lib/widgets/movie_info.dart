import 'package:flutter/material.dart';

class MovieInfo extends StatelessWidget {
  const MovieInfo({
    super.key,
    required this.fields,
    required this.valueWidth,
  });

  final Map<String, dynamic> fields;
  final double valueWidth;

  @override
  Widget build(BuildContext context) {
    final List<String> fieldKeys = fields.keys.toList();

    return Column(
      children: [
        for (int i = 0; i < fieldKeys.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${fieldKeys[i]}:',
                  textAlign: TextAlign.left,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  width: valueWidth,
                  child: Text(
                    '${fields[fieldKeys[i]]}',
                    textAlign: TextAlign.right,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
