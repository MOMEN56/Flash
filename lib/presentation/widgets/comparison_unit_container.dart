import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class UnitSelectionRow extends StatelessWidget {
  final String unit;
  final Function(String) onUnitSelected;

  UnitSelectionRow({
    required this.unit,
    required this.onUnitSelected,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, String> unitMapping = {
      'Ounce': 'toz',
      'Tonne': 'mt',
      'Kilogram': 'kg',
      'Gram': 'g',
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: unitMapping.keys.map((unitName) {
        final isSelected = unit == unitMapping[unitName];
        return GestureDetector(
          onTap: () {
            onUnitSelected(unitMapping[unitName]!);  // استدعاء دالة onUnitSelected
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 8.0.h),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.0.h),
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
          ),
        );
      }).toList(),
    );
  }
}
