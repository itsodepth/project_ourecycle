import 'package:flutter/material.dart';

class WeightSelectorWidget extends StatelessWidget {
  final List<String> weights;
  final String? selectedWeight;
  final ValueChanged<String> onWeightSelected;
  final String sectionTitle;

  const WeightSelectorWidget({
    super.key,
    required this.weights,
    required this.selectedWeight,
    required this.onWeightSelected,
    this.sectionTitle = "Berat Sampahmu?",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              weights.map((weight) {
                bool isSelected = selectedWeight == weight;
                return GestureDetector(
                  onTap: () => onWeightSelected(weight),
                  child: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? Colors.green.shade600
                              : Colors.green.shade400,
                      shape: BoxShape.circle,
                      boxShadow:
                          isSelected
                              ? [
                                BoxShadow(
                                  color: Colors.green.shade700.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                              : [],
                    ),
                    child: Center(
                      child: Text(
                        '$weight\nkg',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
