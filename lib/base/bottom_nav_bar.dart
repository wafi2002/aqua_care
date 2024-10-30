import 'package:aqua_care/screens/ai/educational_content_screen.dart';
import 'package:aqua_care/screens/home/home_screen.dart';
import 'package:aqua_care/screens/map/map_screen.dart';
import 'package:aqua_care/screens/report/report_problem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:aqua_care/controller/bottom_nav_controller.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  // Dependency injection
  final BottomNavController controller = Get.put(BottomNavController());

  final appScreens = [
    const HomeScreen(),
    const MapScreen(),
    const ReportProblem(),
    EducationalContentScreen(topic: 'water conservation'),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: appScreens[controller.selectedIndex.value],

        // Wrapping the BottomNavigationBar with ClipRRect for rounded corners
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)), // Rounded corners
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.shifting, // Shifting style for animation
              currentIndex: controller.selectedIndex.value,
              onTap: controller.onItemTapped,
              selectedItemColor: Colors.blue,
              unselectedItemColor: const Color(0xFF526400),
              showSelectedLabels: false,
              showUnselectedLabels: false, // Hide labels for a clean look
              items: [
                BottomNavigationBarItem(
                  icon: AnimatedOpacity(
                    opacity: controller.selectedIndex.value == 0 ? 1.0 : 0.5,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(FluentSystemIcons.ic_fluent_home_add_regular),
                  ),
                  activeIcon: const Icon(FluentSystemIcons.ic_fluent_home_filled),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: AnimatedOpacity(
                    opacity: controller.selectedIndex.value == 1 ? 1.0 : 0.5,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(FluentSystemIcons.ic_fluent_search_regular),
                  ),
                  activeIcon: const Icon(FluentSystemIcons.ic_fluent_search_filled),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: AnimatedOpacity(
                    opacity: controller.selectedIndex.value == 2 ? 1.0 : 0.5,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(FluentSystemIcons.ic_fluent_document_regular),
                  ),
                  activeIcon: const Icon(FluentSystemIcons.ic_fluent_document_filled),
                  label: "Report",
                ),
                BottomNavigationBarItem(
                  icon: AnimatedOpacity(
                    opacity: controller.selectedIndex.value == 3 ? 1.0 : 0.5,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(FluentSystemIcons.ic_fluent_settings_regular),
                  ),
                  activeIcon: const Icon(FluentSystemIcons.ic_fluent_settings_filled),
                  label: "AI",
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

