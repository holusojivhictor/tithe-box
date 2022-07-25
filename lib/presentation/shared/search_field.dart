import 'package:flutter/material.dart';
import 'package:tithe_box/theme.dart';

typedef SearchChanged = void Function(String val);

class SearchField extends StatefulWidget {
  final String? value;
  final bool showClearButton;
  final SearchChanged searchChanged;
  final EdgeInsets padding;
  final String hintText;

  const SearchField({
    Key? key,
    this.value,
    required this.searchChanged,
    this.showClearButton = true,
    this.padding = EdgeInsets.zero,
    this.hintText = 'Search',
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _searchFocusNode = FocusNode();
  late TextEditingController _searchBoxTextController;

  @override
  void initState() {
    super.initState();
    _searchBoxTextController = TextEditingController(text: widget.value);
    _searchBoxTextController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _searchBoxTextController.removeListener(_onSearchTextChanged);
    _searchBoxTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customTheme = Theme.of(context).extension<CustomTheme>()!;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      constraints: BoxConstraints(maxWidth: screenWidth * 0.9),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchBoxTextController,
                focusNode: _searchFocusNode,
                cursorColor: theme.primaryColor,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(
                  border: Styles.searchFieldBorder,
                  filled: true,
                  fillColor: customTheme.categoryOverlay,
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(fontSize: 15),
                  prefixIcon: Container(
                    margin: Styles.edgeInsetAll5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.primaryColor,
                    ),
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 13,
                  ),
                ),
              ),
            ),
            if (widget.value != null && widget.value!.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.close),
                splashRadius: 15,
                onPressed: _cleanSearchText,
              ),
          ],
        ),
      ),
    );
  }

  void _onSearchTextChanged() => widget.searchChanged(_searchBoxTextController.text);

  void _cleanSearchText() {
    _searchFocusNode.requestFocus();
    if (_searchBoxTextController.text.isEmpty) {
      return;
    }
    _searchBoxTextController.text = '';
  }
}