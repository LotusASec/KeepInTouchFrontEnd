import 'package:flutter/material.dart';

class StatusFilter extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const StatusFilter({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Wrap(
        spacing: 8,
        children: [
          _buildFilterChip('all', 'All'),
          _buildFilterChip('created', 'Created'),
          _buildFilterChip('sent', 'Sent'),
          _buildFilterChip('filled', 'Filled'),
          _buildFilterChip('controlled', 'Controlled'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    final isSelected = selectedFilter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onFilterChanged(value),
      selectedColor: Colors.blue.withValues(alpha: 0.2),
      checkmarkColor: Colors.blue,
      backgroundColor: Colors.grey.withValues(alpha: 0.2),
    );
  }
}