import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavigation extends StatelessWidget {
  final selectedIndex;
  final Function(int index) setSelectedIndex;

  const CustomBottomNavigation(
      {Key? key, required this.selectedIndex, required this.setSelectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 2,
                  offset: Offset(1, 1)),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            onTap: (index) => setSelectedIndex(index),
            currentIndex: selectedIndex,
            backgroundColor: Colors.transparent,
            showUnselectedLabels: true,
            unselectedLabelStyle: TextStyle(fontSize: 10),
            selectedLabelStyle:
                TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: CircleAvatar(
                    radius: 20,
                    backgroundColor: selectedIndex == 0
                        ? Palettes.kcBlueMain1.withOpacity(0.2)
                        : Colors.transparent,
                    child: SvgPicture.asset(
                      'assets/icons/Home.svg',
                      height: 23,
                      color: selectedIndex == 0
                          ? Palettes.kcBlueMain2
                          : Palettes.kcNeutral1,
                    )),
              ),
              BottomNavigationBarItem(
                label: 'Appointment',
                icon: CircleAvatar(
                    radius: 20,
                    backgroundColor: selectedIndex == 1
                        ? Palettes.kcBlueMain1.withOpacity(0.2)
                        : Colors.transparent,
                    child: SvgPicture.asset(
                      'assets/icons/Calendar.svg',
                      height: 23,
                      color: selectedIndex == 1
                          ? Palettes.kcBlueMain2
                          : Palettes.kcNeutral1,
                    )),
              ),
              BottomNavigationBarItem(
                label: 'Patients',
                icon: CircleAvatar(
                    radius: 20,
                    backgroundColor: selectedIndex == 2
                        ? Palettes.kcBlueMain1.withOpacity(0.2)
                        : Colors.transparent,
                    child: SvgPicture.asset(
                      'assets/icons/Clients.svg',
                      height: 23,
                      color: selectedIndex == 2
                          ? Palettes.kcBlueMain2
                          : Palettes.kcNeutral1,
                    )),
              ),
              BottomNavigationBarItem(
                label: 'Services',
                icon: CircleAvatar(
                    radius: 20,
                    backgroundColor: selectedIndex == 3
                        ? Palettes.kcBlueMain1.withOpacity(0.2)
                        : Colors.transparent,
                    child: SvgPicture.asset(
                      'assets/icons/Filter.svg',
                      height: 23,
                      color: selectedIndex == 3
                          ? Palettes.kcBlueMain2
                          : Palettes.kcNeutral1,
                    )),
              ),
              BottomNavigationBarItem(
                label: 'Medicine',
                icon: CircleAvatar(
                    radius: 20,
                    backgroundColor: selectedIndex == 4
                        ? Palettes.kcBlueMain1.withOpacity(0.2)
                        : Colors.transparent,
                    child: SvgPicture.asset(
                      'assets/icons/Work.svg',
                      height: 23,
                      color: selectedIndex == 4
                          ? Palettes.kcBlueMain2
                          : Palettes.kcNeutral1,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
