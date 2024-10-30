import 'package:flutter/material.dart';

class CustomSearchTextField extends StatelessWidget {
  final Function(String)? onChanged;

  const CustomSearchTextField({
    super.key,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search Water Source...',
        prefixIcon: const Icon(Icons.search,color: Colors.white,),
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        // Customize the border when the TextField is focused
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.yellow,
            width: 2.0,
          ),
        ),
        // Customize the border when there is an error
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        // Customize the border when the TextField is focused and there's an error
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
      ),
      onChanged: onChanged, // Pass the onChanged function
    );
  }
}
