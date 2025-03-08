import 'package:flutter/material.dart';

class LoadingErrorWidget extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;

  const LoadingErrorWidget({
    super.key,
    required this.isLoading,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator()); 
    } else if (errorMessage != null && errorMessage!.isNotEmpty) {
      return Center(
        child: Text(
          errorMessage!, 
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      ); 
    } else {
      return const SizedBox.shrink(); 
    }
  }
}
