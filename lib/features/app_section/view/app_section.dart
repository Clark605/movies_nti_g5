import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/core/constants/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';

class AppSection extends StatefulWidget {
  const AppSection({super.key});
  static const String routeName = '/home';

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  int _currentIndex = 0;
  List<Widget> pages = [
    const Center(child: Text('Cart Page')),
    const Center(child: Text('Favorites Page')),
    const Center(child: Text('Profile Page')),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.homeIcon,
              colorFilter: ColorFilter.mode(
                _currentIndex == 0 ? AppColors.secondaryColor : AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              child: SvgPicture.asset(
                AppAssets.searchBarIcon,
                colorFilter: ColorFilter.mode(
                  _currentIndex == 1
                      ? AppColors.secondaryColor
                      : AppColors.grey,
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.watchlistIcon,
              colorFilter: ColorFilter.mode(
                _currentIndex == 2 ? AppColors.secondaryColor : AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            label: 'Watchlist',
          ),
        ],
      ),
    );
  }
}
