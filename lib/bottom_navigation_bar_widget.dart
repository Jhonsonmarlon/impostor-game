import 'package:flutter/material.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';
import 'main.dart';  // Importa a enum SelectedTab

class BottomNavigationBarWidget extends StatelessWidget {
  final SelectedTab selectedTab;
  final Function(int) onTap;

  const BottomNavigationBarWidget({
    super.key,
    required this.selectedTab,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: CrystalNavigationBar(
        currentIndex: SelectedTab.values.indexOf(selectedTab),
        height: 60,
        backgroundColor: Colors.black.withOpacity(0.1),
        onTap: onTap,
        items: [
          CrystalNavigationBarItem(
            icon: IconlyBold.home,
            unselectedIcon: IconlyLight.home,
            unselectedColor: const Color.fromARGB(255, 139, 139, 139),
            selectedColor: Colors.white,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.plus,
            unselectedIcon: IconlyLight.plus,
            unselectedColor: const Color.fromARGB(255, 139, 139, 139),
            selectedColor: Colors.white,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.heart,
            unselectedIcon: IconlyLight.heart,
            unselectedColor: const Color.fromARGB(255, 139, 139, 139),
            selectedColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
