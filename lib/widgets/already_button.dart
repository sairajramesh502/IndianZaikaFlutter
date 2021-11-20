import 'package:flutter/material.dart';
import 'package:indian_zaika/constants/constants.dart';

class AlreadyButton extends StatefulWidget {
  final GestureTapCallback? onPressed;
  final String firstText;
  final String secondText;
  const AlreadyButton(
      {Key? key,
      required this.onPressed,
      required this.firstText,
      required this.secondText})
      : super(key: key);

  @override
  _AlreadyButtonState createState() => _AlreadyButtonState();
}

class _AlreadyButtonState extends State<AlreadyButton> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth,
      height: screenWidth / 7,
      child: TextButton(
        child: RichText(
          text: TextSpan(
            text: widget.firstText,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
            children: <TextSpan>[
              TextSpan(
                text: widget.secondText,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: kAccentColor,
                ),
              ),
            ],
          ),
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}
