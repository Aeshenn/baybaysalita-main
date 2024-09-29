import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RectangularButton extends StatelessWidget {
  const RectangularButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: SizedBox(
        height: 50,
        width: 250,
        child: Card(
          color: onPressed != null ? Color(0xfff5505b) : null,
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.fredoka(
                          textStyle: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.w400
                          ),
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
