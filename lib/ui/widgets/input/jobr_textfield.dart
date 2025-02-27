import 'package:flutter/material.dart';
import 'package:jobr/ui/theme/text_styles.dart';

class JobrTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Color? hintTextColor;
  final Color? formColor;
  final double borderRadius;
  final double width;
  final double height;
  final EdgeInsets contentPadding;
  final bool obscureText;
  final bool isPassword;

  const JobrTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.hintTextColor,
    this.formColor,
    this.borderRadius = 27,
    this.width = 346,
    this.height = 42,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 23),
    this.obscureText = false,
    this.isPassword = false,
  });

  @override
  _JobrTextFieldState createState() => _JobrTextFieldState();
}

class _JobrTextFieldState extends State<JobrTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  void _toggleObscure() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: SizedBox(
        width: widget.width,
        child: TextField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscure : widget.obscureText,
          style: TextStyles.bodySmall,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 17.5,
              fontWeight: FontWeight.w500,
              color: widget.hintTextColor ??
                  Colors.grey[400] ??
                  Theme.of(context).hintColor,
            ),
            contentPadding: widget.contentPadding.copyWith(
              top: (widget.height - 17.5) / 2,
              bottom: (widget.height - 17.5) / 2,
            ),
            filled: true,
            fillColor: widget.formColor ??
                Theme.of(context).inputDecorationTheme.fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none,
            ),
            suffixIcon: widget.isPassword
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                      icon: Icon(
                          color: Colors.grey[400],
                          _obscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: _toggleObscure,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
