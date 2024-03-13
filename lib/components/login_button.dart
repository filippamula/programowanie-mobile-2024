import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  final String text;
  final Function()? onTap;

  const LoginButton({super.key, required this.text, this.onTap});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _isLoading = true;
          });
          Future function = widget.onTap?.call();
          function.then((value) => setState(() {
                _isLoading = false;
              }));
        },
        child: Container(
            height: 70,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        widget.text,
                        style: const TextStyle(
                            color: Colors.indigoAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ))));
  }
}
