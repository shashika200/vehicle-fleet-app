import 'package:flutter/material.dart';

class FilterBar extends StatefulWidget {
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
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchQuery);
  }

  // Update the controller if the widget's initial search query changes from the parent
  @override
  void didUpdateWidget(FilterBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery &&
        widget.searchQuery != _searchController.text) {
      _searchController.text = widget.searchQuery;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
          ? _buildWideLayout(context)
          : _buildNarrowLayout(context),
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: _buildSearchField(),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: _buildStatusDropdown(context),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout(BuildContext context) {
    return Column(
      children: [
        _buildSearchField(),
        const SizedBox(height: 12),
        _buildStatusDropdown(context),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      onChanged: (value) => widget.onFilterChanged(widget.statusFilter, value),
      decoration: InputDecoration(
        labelText: 'Search by name, number, or location',
        hintText: 'Enter search term...',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).brightness == Brightness.light
            ? Colors.grey.shade200
            : Colors.grey.shade800,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  Widget _buildStatusDropdown(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.grey.shade200
            : Colors.grey.shade800,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: widget.statusFilter,
          onChanged: (value) {
            if (value != null) {
              widget.onFilterChanged(value, _searchController.text);
            }
          },
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
