import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Roundbutton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onTap;
  const Roundbutton({super.key, required this.title, required this.onTap, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(

        height: 50,
        width: 350,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: loading? CircularProgressIndicator(strokeWidth: 3,color: Colors.white,): Text(title, style: TextStyle(color: Colors.white, fontSize: 18),)),

      ),
    );
  }
}
