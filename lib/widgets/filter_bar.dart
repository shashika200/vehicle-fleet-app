import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final Function(String, String) onFilterChanged;
  final String statusFilter;
  final String searchQuery;

  const FilterBar({
    super.key,
    required this.onFilterChanged,
    required this.statusFilter,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: screenWidth > 600
          ? _buildWideLayout()
          : _buildNarrowLayout(),
    );
  }

  Widget _buildWideLayout() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: _buildSearchField(),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: _buildStatusDropdown(),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return Column(
      children: [
        _buildSearchField(),
        const SizedBox(height: 12),
        _buildStatusDropdown(),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: TextEditingController(text: searchQuery),
      onChanged: (value) => onFilterChanged(statusFilter, value),
      decoration: InputDecoration(
        labelText: 'Search by name, number, or location',
        hintText: 'Enter search term...',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey.shade200,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: statusFilter,
          onChanged: (value) => onFilterChanged(value!, searchQuery),
          items: ['All', 'Available', 'Under Repair', 'Unavailable']
              .map((status) => DropdownMenuItem(
                    value: status,
                    child: Text(status, style: const TextStyle(fontSize: 14)),
                  ))
              .toList(),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
        ),
      ),
    );
  }
}
