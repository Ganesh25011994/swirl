import 'package:flutter/material.dart';

class CustomNavigationRail extends StatelessWidget {
  final int selectedIndex;
  final List<IconData>? icons;
  final List<String>? label;
  final bool isExtend;
  final Function(int) onDestinationSelected;
  final Color? backgroundColor;

  const CustomNavigationRail({
    super.key,
    required this.selectedIndex,
    this.icons,
    this.label,
    required this.isExtend,
    required this.onDestinationSelected,
    this.backgroundColor,
    });
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      destinations:List.generate(label!.length, (index){
        return NavigationRailDestination(icon: Icon(icons![index]), label: Text(label![index]),padding: EdgeInsets.all(5));
      }),
      labelType: isExtend ? NavigationRailLabelType.none : NavigationRailLabelType.all,
      selectedIndex: selectedIndex,
      extended: isExtend,
      onDestinationSelected: onDestinationSelected,
      backgroundColor: backgroundColor,
      selectedIconTheme: IconThemeData(size: 15),
    );
  }
}
