import 'package:flutter/material.dart';
import '../../../app/theme.dart';

class AppHeader extends StatelessWidget {

  const AppHeader({
    super.key,
    required this.pageTitle,
    this.onMenuTap,
    this.onNotificationTap,
    this.hasUnreadNotifications = false,
  });
  final String pageTitle;
  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationTap;
  final bool hasUnreadNotifications;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 14,
        20,
        16,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryBlue,
            AppTheme.primaryBlueLight,
          ],
        ),
        // Removed borderRadius
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue,
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // Menu Button (hamburger)
          _CircleIconButton(
            icon: Icons.menu_rounded,
            onPressed: onMenuTap,
          ),
          const SizedBox(width: 14),
          // Page Title
          Expanded(
            child: Text(
              pageTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: -0.3,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Notification Icon
          _CircleIconButton(
            icon: Icons.notifications_rounded,
            onPressed: onNotificationTap,
            showBadge: hasUnreadNotifications,
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {

  const _CircleIconButton({
    required this.icon,
    required this.onPressed,
    this.showBadge = false,
  });
  final IconData icon;
  final VoidCallback? onPressed;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: Colors.white.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(icon, size: 20, color: Colors.white),
            ),
          ),
        ),
        if (showBadge)
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: AppTheme.error,
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.primaryBlue, width: 1.5),
              ),
            ),
          ),
      ],
    );
  }
}