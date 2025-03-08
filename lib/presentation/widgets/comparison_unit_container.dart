import 'package:flash/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComparisonUnitContainer extends StatelessWidget {
  final String unit;
  final Function(String) onUnitSelected;

  const ComparisonUnitContainer({
    super.key,
    required this.unit,
    required this.onUnitSelected,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, String> unitMapping = {
      S.of(context).gram: 'g',
      S.of(context).Ounce: 'toz',
      S.of(context).kilo: 'kg',
      S.of(context).tonne: 'mt',
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: unitMapping.keys.map((unitName) {
        final isSelected = unit == unitMapping[unitName];
        return GestureDetector(
          onTap: () {
            onUnitSelected(
                unitMapping[unitName]!); 
          },
          child: Container(
            padding:
                EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 10.0.h),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              unitName,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
