import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyListTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  const CurrencyListTile({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.onTap,
    required this.isFavorite,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 72.5.h,
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: Color(0xFF5d6d7e),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      imageUrl,
                      width: 40.h,
                      height: 40.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  Text(
                    '$price\$',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      size: 18.w,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: onFavoritePressed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
