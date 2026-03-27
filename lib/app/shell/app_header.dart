import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/theme_exports.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/college_selector_bloc.dart';

/// The top header bar with college selector, search, notifications, and profile.
class AppHeader extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final UserModel user;

  const AppHeader({
    super.key,
    this.onMenuTap,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppSpacing.mobileBreakpoint;

    return Container(
      height: AppSpacing.headerHeight,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 20),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          if (onMenuTap != null)
            IconButton(
              onPressed: onMenuTap,
              icon: const Icon(Icons.menu_rounded, size: 22),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            ),
          Flexible(child: _buildCollegeSelector(context)),
          const Spacer(),
          if (!isMobile) ...[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search_rounded, size: 22),
              style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary),
            ),
            const SizedBox(width: 4),
          ],
          _buildNotificationButton(),
          if (!isMobile) ...[
            Container(
              width: 1, height: 28,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: AppColors.border,
            ),
            _buildProfileMenu(context, compact: false),
          ] else
            _buildProfileMenu(context, compact: true),
        ],
      ),
    );
  }

  Widget _buildCollegeSelector(BuildContext context) {
    return BlocBuilder<CollegeSelectorBloc, CollegeSelectorState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(left: 8),
          child: PopupMenuButton<int?>(
            offset: const Offset(0, 44),
            shape: RoundedRectangleBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              side: const BorderSide(color: AppColors.borderLight),
            ),
            onSelected: (id) {
              context.read<CollegeSelectorBloc>().add(CollegeSelectorChanged(collegeId: id));
            },
            itemBuilder: (_) => [
              PopupMenuItem<int?>(
                value: null,
                child: Row(children: [
                  Icon(Icons.all_inclusive_rounded, size: 18,
                    color: state.selectedCollegeId == null ? AppColors.accent : AppColors.textSecondary),
                  const SizedBox(width: 10),
                  Text('All Colleges', style: AppTypography.bodySmall.copyWith(
                    fontWeight: state.selectedCollegeId == null ? FontWeight.w600 : FontWeight.w400,
                    color: state.selectedCollegeId == null ? AppColors.accent : AppColors.textPrimary,
                  )),
                ]),
              ),
              const PopupMenuDivider(),
              ...state.colleges.map((c) => PopupMenuItem<int>(
                value: c.id,
                child: Row(children: [
                  Container(
                    width: 28, height: 28,
                    decoration: BoxDecoration(
                      color: state.selectedCollegeId == c.id ? AppColors.accentSurface : AppColors.surfaceVariant,
                      borderRadius: AppSpacing.borderRadiusXs,
                    ),
                    child: Center(child: Text(c.code, style: AppTypography.tag.copyWith(
                      color: state.selectedCollegeId == c.id ? AppColors.accent : AppColors.textSecondary,
                      fontWeight: FontWeight.w600, fontSize: 9,
                    ))),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(c.name, style: AppTypography.bodySmall.copyWith(
                    fontWeight: state.selectedCollegeId == c.id ? FontWeight.w600 : FontWeight.w400,
                  ))),
                  if (state.selectedCollegeId == c.id)
                    const Icon(Icons.check, size: 16, color: AppColors.accent),
                ]),
              )),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: AppSpacing.borderRadiusSm,
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.apartment_rounded, size: 14, color: AppColors.accent),
                  const SizedBox(width: 4),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: isMobile ? 80 : 120),
                    child: Text(
                      state.displayName,
                      style: AppTypography.caption.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w500),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: AppColors.textSecondary),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotificationButton() {
    return Stack(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined, size: 22),
          style: IconButton.styleFrom(foregroundColor: AppColors.textSecondary),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
        ),
        Positioned(
          top: 8, right: 8,
          child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle)),
        ),
      ],
    );
  }

  Widget _buildProfileMenu(BuildContext context, {required bool compact}) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 44),
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusMd,
        side: const BorderSide(color: AppColors.borderLight),
      ),
      onSelected: (value) {
        if (value == 'logout') {
          context.read<AuthBloc>().add(const AuthLogoutRequested());
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem<String>(
          enabled: false,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(user.fullName, style: AppTypography.h4),
            Text(user.email, style: AppTypography.caption),
          ]),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(value: 'profile', child: Row(children: [Icon(Icons.person_outline_rounded, size: 18), SizedBox(width: 8), Text('My Profile')])),
        const PopupMenuItem(value: 'settings', child: Row(children: [Icon(Icons.settings_outlined, size: 18), SizedBox(width: 8), Text('Settings')])),
        const PopupMenuDivider(),
        PopupMenuItem(value: 'logout', child: Row(children: [
          Icon(Icons.logout_rounded, size: 18, color: AppColors.error),
          const SizedBox(width: 8),
          Text('Sign Out', style: TextStyle(color: AppColors.error)),
        ])),
      ],
      child: compact
          ? Container(
              width: 36, height: 36,
              decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: AppSpacing.borderRadiusMd),
              child: Center(child: Text(user.initials, style: AppTypography.labelSmall.copyWith(color: Colors.white, fontWeight: FontWeight.w600))),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: AppSpacing.borderRadiusMd),
                  child: Center(child: Text(user.initials, style: AppTypography.labelMedium.copyWith(color: Colors.white, fontWeight: FontWeight.w600))),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.fullName, style: AppTypography.labelMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
                    Text('Super Admin', style: AppTypography.caption.copyWith(fontSize: 10)),
                  ],
                ),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: AppColors.textSecondary),
              ],
            ),
    );
  }
}
