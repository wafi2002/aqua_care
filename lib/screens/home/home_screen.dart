import 'package:aqua_care/base/res/styles/app_styles.dart';
import 'package:aqua_care/base/widgets/app_double_text.dart';
import 'package:aqua_care/screens/ai/educational_content_screen.dart';
import 'package:aqua_care/screens/home/widgets/WaterSourceMap.dart';
import 'package:aqua_care/screens/map/map_screen.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the PageController for controlling and tracking the PageView
    final PageController pageController = PageController();

    return Scaffold(
      backgroundColor: AppStyles.skyBlue,
      body: ListView(
        children: [
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section with greeting
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Good morning!', style: AppStyles.headLineStyle4),
                        const SizedBox(height: 5),
                        Text('Welcome to Aqua Care', style: AppStyles.headLineStyle5),
                      ],
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/aqua care.jpg"))),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Search bar container
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFF4F6FD),
                  ),
                  child: const Row(
                    children: [
                      Icon(FluentSystemIcons.ic_fluent_search_regular,
                          color: Color(0xFFBFC205)),
                      Text('Search'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Locate water source button
                AppDoubleText(
                  bigText: 'Locate nearby water source',
                  smallText: 'View',
                  func: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapScreen()),
                  ),
                ),
                const SizedBox(height: 10),
                const WaterSourceMap(),
                const SizedBox(height: 20),
                AppDoubleText(
                  bigText: 'Want to Save Water?',
                  smallText: 'Ask AquaBot',
                  func: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EducationalContentScreen(topic: 'water conservation')),
                  ),
                ),
                const SizedBox(height: 10),

                // Image Slider with SmoothPageIndicator
                SizedBox(
                  height: 200,
                  child: PageView(
                    controller: pageController, // Attach the PageController
                    scrollDirection: Axis.horizontal,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
                        child: Image.asset('assets/images/sea.jpg', fit: BoxFit.cover),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
                        child: Image.asset('assets/images/sungai.jpg', fit: BoxFit.cover),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
                        child: Image.asset('assets/images/water.jpg', fit: BoxFit.cover),
                      ),
                    ],
                  ),
                ),


                const SizedBox(height: 10),

                // SmoothPageIndicator added below the PageView
                Center(
                  child: SmoothPageIndicator(
                    controller: pageController, // Attach the PageController
                    count: 3, // Number of images in the PageView
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.blue, // Color of the active dot
                      dotColor: Colors.grey.shade400, // Color of the inactive dots
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 3, // Dot expansion effect
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
