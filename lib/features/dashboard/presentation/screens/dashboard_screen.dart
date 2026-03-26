import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppSpacing.mobileBreakpoint;
    final padding = isMobile ? AppSpacing.pagePaddingMobile : AppSpacing.pagePadding;

    return SingleChildScrollView(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(title: 'Dashboard', subtitle: 'Welcome back! Here\'s your institution overview.'),
          _buildMetrics(),
          const SizedBox(height: 20),
          ResponsiveRow(left: _buildRevenueChart(), right: _buildIncomeSourcesChart()),
          const SizedBox(height: 20),
          ResponsiveRow(left: _buildRecentActivities(), right: _buildPendingTasks()),
          const SizedBox(height: 20),
          ResponsiveRow(left: _buildQuickActions(), right: _buildUpcomingEvents(), leftFlex: 1, rightFlex: 1),
          const SizedBox(height: 20),
          _buildSystemAlerts(),
          const SizedBox(height: 20),
          _buildCollegeOverview(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMetrics() {
    return ResponsiveGrid(
      children: [
        MetricCard(label: 'Total Students', value: '2,340', icon: Icons.people_rounded, iconColor: AppColors.accent, iconBgColor: AppColors.accentSurface, trend: '+8.2%', trendUp: true),
        MetricCard(label: 'Teaching Staff', value: '156', icon: Icons.person_rounded, iconColor: AppColors.success, iconBgColor: AppColors.successSurface, trend: '+3.1%', trendUp: true),
        MetricCard(label: 'Revenue This Year', value: '\u20B9 1.8Cr', icon: Icons.account_balance_wallet_rounded, iconColor: AppColors.secondary, iconBgColor: AppColors.secondarySurface, trend: '+12.5%', trendUp: true),
        MetricCard(label: 'Avg. Attendance', value: '89.3%', icon: Icons.fact_check_rounded, iconColor: AppColors.info, iconBgColor: AppColors.infoSurface, trend: '-1.2%', trendUp: false),
      ],
    );
  }

  Widget _buildRevenueChart() {
    return AppCard(
      title: 'Revenue Overview',
      subtitle: 'Monthly revenue trend',
      child: SizedBox(
        height: 220,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 60,
            barTouchData: BarTouchData(enabled: false),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, _) {
                const m = ['A','M','J','J','A','S','O','N','D','J','F','M'];
                return Padding(padding: const EdgeInsets.only(top: 6), child: Text(m[v.toInt()], style: AppTypography.caption.copyWith(fontSize: 10)));
              })),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 28, interval: 20, getTitlesWidget: (v, _) => Text('${v.toInt()}', style: AppTypography.caption.copyWith(fontSize: 9)))),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: true, horizontalInterval: 20, getDrawingHorizontalLine: (v) => FlLine(color: AppColors.border, strokeWidth: 1, dashArray: [4, 4]), drawVerticalLine: false),
            barGroups: [for (var i = 0; i < 12; i++) BarChartGroupData(x: i, barRods: [BarChartRodData(toY: [35,42,28,38,45,40,52,48,35,55,50,42][i].toDouble(), color: AppColors.accent, width: 10, borderRadius: const BorderRadius.vertical(top: Radius.circular(3)))])],
          ),
        ),
      ),
    );
  }

  Widget _buildIncomeSourcesChart() {
    final sources = [('Tuition', 45.0, AppColors.chartColors[0]), ('Hostel', 20.0, AppColors.chartColors[1]), ('Lab', 15.0, AppColors.chartColors[2]), ('Transport', 10.0, AppColors.chartColors[3]), ('Others', 10.0, AppColors.chartColors[4])];
    return AppCard(
      title: 'Income Sources',
      child: Column(children: [
        SizedBox(height: 140, child: PieChart(PieChartData(sectionsSpace: 2, centerSpaceRadius: 30, sections: sources.map((s) => PieChartSectionData(value: s.$2, color: s.$3, radius: 28, showTitle: false)).toList()))),
        const SizedBox(height: 12),
        ...sources.map((s) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Row(children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: s.$3, borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 8),
          Expanded(child: Text(s.$1, style: AppTypography.caption)),
          Text('${s.$2.toStringAsFixed(0)}%', style: AppTypography.labelSmall.copyWith(fontWeight: FontWeight.w600)),
        ]))),
      ]),
    );
  }

  Widget _buildRecentActivities() {
    return AppCard(
      title: 'Recent Activities',
      child: Column(children: [
        _activityItem('New student registered', 'Abebe Kebede enrolled in B.Tech CSE', Icons.person_add_rounded, AppColors.accent, '2 min ago'),
        const SizedBox(height: 12),
        _activityItem('Indent approved', 'Lab equipment indent #1024 approved', Icons.check_circle_rounded, AppColors.success, '15 min ago'),
      ]),
    );
  }

  Widget _activityItem(String title, String desc, IconData icon, Color color, String time) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 32, height: 32, decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusSm), child: Icon(icon, size: 16, color: color)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: AppTypography.labelMedium.copyWith(color: AppColors.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis),
        Text(desc, style: AppTypography.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
      ])),
      Text(time, style: AppTypography.caption.copyWith(fontSize: 10)),
    ]);
  }

  Widget _buildPendingTasks() {
    return AppCard(
      title: 'Pending Tasks',
      subtitle: '2 items need attention',
      child: Column(children: [
        _taskItem('Review indent #1025', 'Store', AppColors.warning, 'High'),
        const SizedBox(height: 8),
        _taskItem('Approve salary structure', 'HR', AppColors.error, 'Urgent'),
      ]),
    );
  }

  Widget _taskItem(String title, String module, Color color, String priority) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: AppColors.surfaceVariant.withValues(alpha: 0.5), borderRadius: AppSpacing.borderRadiusSm, border: Border(left: BorderSide(color: color, width: 3))),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: AppTypography.labelMedium.copyWith(color: AppColors.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis),
          Text(module, style: AppTypography.caption),
        ])),
        StatusBadge.priority(priority),
      ]),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      ('Add Student', Icons.person_add_rounded, AppColors.accent),
      ('Create Indent', Icons.add_shopping_cart_rounded, AppColors.success),
      ('Send Notice', Icons.campaign_rounded, AppColors.secondary),
      ('Reports', Icons.assessment_rounded, AppColors.info),
    ];
    return AppCard(
      title: 'Quick Actions',
      child: GridView.count(
        shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2,
        children: actions.map((a) => Material(
          color: Colors.transparent, borderRadius: AppSpacing.borderRadiusSm,
          child: InkWell(onTap: () {}, borderRadius: AppSpacing.borderRadiusSm, child: Container(
            decoration: BoxDecoration(color: a.$3.withValues(alpha: 0.06), borderRadius: AppSpacing.borderRadiusSm),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(a.$2, size: 18, color: a.$3),
              const SizedBox(width: 8),
              Flexible(child: Text(a.$1, style: AppTypography.labelSmall.copyWith(color: AppColors.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis)),
            ]),
          )),
        )).toList(),
      ),
    );
  }

  Widget _buildUpcomingEvents() {
    return AppCard(
      title: 'Upcoming Events',
      child: Column(children: [
        _eventItem('Faculty Meeting', 'Mar 28, 10:00 AM', Icons.groups_rounded, AppColors.accent),
        const SizedBox(height: 10),
        _eventItem('Semester Exam', 'Apr 5, 9:00 AM', Icons.quiz_rounded, AppColors.error),
      ]),
    );
  }

  Widget _eventItem(String title, String date, IconData icon, Color color) {
    return Row(children: [
      Container(width: 36, height: 36, decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusSm), child: Icon(icon, size: 18, color: color)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: AppTypography.labelMedium.copyWith(color: AppColors.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis),
        Text(date, style: AppTypography.caption),
      ])),
    ]);
  }

  Widget _buildSystemAlerts() {
    return AppCard(
      title: 'System Alerts',
      child: Column(children: [
        _alertItem('Database backup completed', 'Last backup: 2 hours ago', Icons.cloud_done_rounded, AppColors.success),
        const SizedBox(height: 8),
        _alertItem('Scheduled maintenance', 'Mar 30, 2–4 AM IST', Icons.engineering_rounded, AppColors.info),
      ]),
    );
  }

  Widget _alertItem(String title, String sub, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.05), borderRadius: AppSpacing.borderRadiusSm, border: Border.all(color: color.withValues(alpha: 0.15))),
      child: Row(children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: AppTypography.labelMedium.copyWith(color: AppColors.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis),
          Text(sub, style: AppTypography.caption),
        ])),
      ]),
    );
  }

  Widget _buildCollegeOverview() {
    return AppCard(
      title: 'Institution Overview',
      child: Column(children: [
        _collegeRow('College of Engineering', 1240, 85, 91.2, AppColors.accent),
        const SizedBox(height: 12),
        _collegeRow('College of Medicine', 1100, 71, 94.5, AppColors.success),
      ]),
    );
  }

  Widget _collegeRow(String name, int students, int staff, double attendance, Color color) {
    return Row(children: [
      Container(width: 36, height: 36, decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusSm), child: Icon(Icons.apartment_rounded, size: 18, color: color)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name, style: AppTypography.labelMedium.copyWith(color: AppColors.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis),
        Text('$students students | $staff staff', style: AppTypography.caption),
      ])),
      Text('${attendance}%', style: AppTypography.labelMedium.copyWith(color: color, fontWeight: FontWeight.w600)),
    ]);
  }
}
