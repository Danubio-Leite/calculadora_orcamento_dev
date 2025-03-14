import 'package:flutter/material.dart';
import '../app_colors.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final double elevation;
  final bool hasBackButton;

  const GradientAppBar(
      {super.key,
      required this.title,
      this.actions,
      this.elevation = 4.0,
      this.hasBackButton = true});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      clipBehavior: Clip.antiAlias,
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      leading: hasBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.white),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      elevation: elevation,
      actions: actions,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
          gradient: LinearGradient(
            colors: [
              AppColors.primaryBlue,
              AppColors.secondaryBlue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
