import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget ButtonTile({required title, required Widget child}) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$title Button"),
        child,
      ],
    ),
  );
}
