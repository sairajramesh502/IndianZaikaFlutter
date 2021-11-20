import 'package:flutter/material.dart';

class ButtonGlobal extends StatefulWidget {
  final GestureTapCallback? onPressed;
  final String buttonText;
  const ButtonGlobal(
      {Key? key, required this.onPressed, required this.buttonText})
      : super(key: key);

  @override
  _ButtonGlobalState createState() => _ButtonGlobalState();
}

class _ButtonGlobalState extends State<ButtonGlobal> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth,
      height: screenWidth / 7,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xFFFFC013),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: Text(
          widget.buttonText,
          style: const TextStyle(
              color: Color(0xFF272C2F),
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}
