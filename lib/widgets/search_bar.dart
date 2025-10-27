import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String)? onChanged;
  final Function(bool)? onPressed;
  final String hintText;
  // final bool showSearch;
  const SearchBarWidget({
    super.key,
    this.onChanged,
    this.onPressed,
    required this.hintText,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController searchBarController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 40,
        child: SearchBar(
          leading: Icon(Icons.search, size: 18),
          hintText: widget.hintText,
          controller: searchBarController,
          shadowColor: WidgetStateProperty.all<Color>(Colors.transparent),
          backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
          // surfaceTintColor: WidgetStateProperty.all<Color>(Colors.transparent),
        
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey), // border color here
              borderRadius: BorderRadius.circular(
                8,
              ), // adjust radius as you want
            ),
          ),
          trailing: [
            IconButton(
              onPressed: () {
                searchBarController.clear();
                widget.onPressed!(true);
              },
              icon: Icon(Icons.close, size: 15),
            ),
          ],
          onChanged: (value) {
            widget.onChanged!(value);
          },
        ),
      ),
    );
  }
}
