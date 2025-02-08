import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/date_selection_screen.dart';
import 'date_selection_manager.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _CustomAppBarState extends State<CustomAppBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateToDateSelection() async {
    final dateManager = context.read<DateSelectionManager>();
    final selectedDate = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DateSelectionScreen()),
    );

    if (selectedDate != null) {
      dateManager.updatePeriod(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateManager = Provider.of<DateSelectionManager>(context);
    String selectedPeriod = dateManager.selectedPeriod;

    return AppBar(
      backgroundColor: Colors.red,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: Column(
        children: [
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.primaryDelta! > 5) {
                _tabController.animateTo(0);
              } else if (details.primaryDelta! < -5) {
                _tabController.animateTo(1);
                _navigateToDateSelection();
              }
            },
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTab(
                    text: "Ir Agora",
                    icon: Icons.flash_on,
                    isSelected: _tabController.index == 0,
                    onTap: () => _tabController.animateTo(0),
                  ),
                  _buildTab(
                    text: "Ir Outro Dia",
                    icon: Icons.calendar_today,
                    isSelected: _tabController.index == 1,
                    onTap: () {
                      _tabController.animateTo(1);
                      _navigateToDateSelection();
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "Minha Localização",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    Icon(Icons.expand_more, size: 14, color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              if (_tabController.index == 1)
                GestureDetector(
                  onTap: _navigateToDateSelection,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.nightlight_round, size: 14, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        selectedPeriod.isNotEmpty ? selectedPeriod : "-- - --",
                        style: const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      const Icon(Icons.expand_more, size: 14, color: Colors.white),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTab({
    required String text,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.red.shade800,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? Colors.black : Colors.white,
            ),
            const SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
