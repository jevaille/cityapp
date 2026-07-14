import 'package:flutter/material.dart';
import '../app/theme.dart';

class CategoryFilterButton extends StatelessWidget {

  const CategoryFilterButton({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
    required this.icon,
  });
  final String category;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData icon;

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'concert':
        return const Color(0xFFE91E63);
      case 'sports':
        return const Color(0xFF2196F3);
      case 'education':
        return const Color(0xFF4CAF50);
      case 'government':
        return const Color(0xFF9C27B0);
      case 'community':
        return const Color(0xFFFF9800);
      case 'all':
        return AppTheme.primaryBlue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getCategoryColor(category);
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected 
              ? color.withValues(alpha: 0.1)
              : Colors.grey.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected 
                ? color
                : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? color : AppTheme.textMedium,
                size: 24,
              ),
              const SizedBox(height: 6),
              Text(
                category,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? color : AppTheme.textMedium,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
