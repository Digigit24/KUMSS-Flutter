import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppSpacing.mobileBreakpoint;
    final crossAxisCount = isMobile ? 2 : 4;

    return SingleChildScrollView(
      padding: isMobile ? AppSpacing.pagePaddingMobile : AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Dashboard',
            subtitle: 'Welcome back! Here\'s your institution overview.',
          ),
          _buildMetricsGrid(crossAxisCount),
          const SizedBox(height: 24),
          if (isMobile)
            Column(
              children: [
                _buildRevenueChart(),
                const SizedBox(height: 20),
                _buildIncomeSourcesChart(),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildRevenueChart()),
                const SizedBox(width: 20),
                Expanded(flex: 2, child: _buildIncomeSourcesChart()),
              ],
            ),
          const SizedBox(height: 24),
          if (isMobile)
            Column(
              children: [
                _buildRecentActivities(),
                const SizedBox(height: 20),
                _buildPendingTasks(),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildRecentActivities()),
                const SizedBox(width: 20),
                Expanded(flex: 2, child: _buildPendingTasks()),
              ],
            ),
          const SizedBox(height: 24),
          if (isMobile)
            Column(
              children: [
                _buildQuickActions(),
                const SizedBox(height: 20),
                _buildUpcomingEvents(),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildQuickActions()),
                const SizedBox(width: 20),
                Expanded(child: _buildUpcomingEvents()),
              ],
            ),
          const SizedBox(height: 24),
          _buildSystemAlerts(),
          const SizedBox(height: 24),
          _buildCollegeOverview(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid(int crossAxisCount) {
    final metrics = [
      _MetricData('Total Students', '2,340', Icons.people_rounded, AppColors.accent, AppColors.accentSurface, '+8.2%', true),
      _MetricData('Teaching Staff', '156', Icons.person_rounded, AppColors.success, AppColors.successSurface, '+3.1%', true),
      _MetricData('Revenue This Year', '\u20B9 1.8Cr', Icons.account_balance_wallet_rounded, AppColors.secondary, AppColors.secondarySurface, '+12.5%', true),
      _MetricData('Avg. Attendance', '89.3%', Icons.fact_check_rounded, AppColors.info, AppColors.infoSurface, '-1.2%', false),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: crossAxisCount == 2 ? 1.5 : 1.8,
      ),
      itemCount: metrics.length,
      itemBuilder: (_, i) {
        final m = metrics[i];
        return MetricCard(
          label: m.label, value: m.value, icon: m.icon,
          iconColor: m.iconColor, iconBgColor: m.iconBgColor,
          trend: m.trend, trendUp: m.trendUp,
        );
      },
    );
  }

  Widget _buildRevenueChart() {
    return AppCard(
      title: 'Revenue Overview',
      subtitle: 'Monthly revenue trend',
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: AppSpacing.borderRadiusSm),
        child: Text('FY 2025-26', style: AppTypography.caption),
      ),
      child: SizedBox(
        height: 260,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 60,
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                getTooltipColor: (_) => AppColors.primary,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final months = ['Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar'];
                  return BarTooltipItem('${months[group.x]}\n\u20B9 ${rod.toY.toStringAsFixed(0)}L', AppTypography.tag.copyWith(color: Colors.white));
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
                const months = ['A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D', 'J', 'F', 'M'];
                return Padding(padding: const EdgeInsets.only(top: 8), child: Text(months[value.toInt()], style: AppTypography.caption));
              })),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 32, interval: 15, getTitlesWidget: (value, meta) => Text('${value.toInt()}L', style: AppTypography.caption))),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: true, horizontalInterval: 15, getDrawingHorizontalLine: (value) => FlLine(color: AppColors.border, strokeWidth: 1, dashArray: [4, 4]), drawVerticalLine: false),
            barGroups: [
              _makeBarGroup(0, 35), _makeBarGroup(1, 42), _makeBarGroup(2, 28), _makeBarGroup(3, 38),
              _makeBarGroup(4, 45), _makeBarGroup(5, 40), _makeBarGroup(6, 52), _makeBarGroup(7, 48),
              _makeBarGroup(8, 35), _makeBarGroup(9, 55), _makeBarGroup(10, 50), _makeBarGroup(11, 42),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData _makeBarGroup(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(toY: y, color: AppColors.accent, width: 14, borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        backDrawRodData: BackgroundBarChartRodData(show: true, toY: 60, color: AppColors.surfaceVariant)),
    ]);
  }

  Widget _buildIncomeSourcesChart() {
    final sources = [
      ('Tuition Fees', 45.0, AppColors.chartColors[0]),
      ('Hostel Fees', 20.0, AppColors.chartColors[1]),
      ('Lab Fees', 15.0, AppColors.chartColors[2]),
      ('Transport', 10.0, AppColors.chartColors[3]),
      ('Others', 10.0, AppColors.chartColors[4]),
    ];

    return AppCard(
      title: 'Income Sources',
      subtitle: 'Revenue distribution',
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: PieChart(PieChartData(
              sectionsSpace: 2, centerSpaceRadius: 40,
              sections: sources.map((s) => PieChartSectionData(value: s.$2, color: s.$3, radius: 35, showTitle: false)).toList(),
            )),
          ),
          const SizedBox(height: 16),
          ...sources.map((s) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(children: [
              Container(width: 10, height: 10, decoration: BoxDecoration(color: s.$3, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 8),
              Expanded(child: Text(s.$1, style: AppTypography.bodySmall)),
              Text('${s.$2.toStringAsFixed(0)}%', style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w600)),
            ]),
          )),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
    final activities = [
      _Activity('New student registered', 'Abebe Kebede enrolled in B.Tech CSE', Icons.person_add_rounded, AppColors.accent, '2 min ago'),
      _Activity('Indent approved', 'Lab equipment indent #1024 approved by CEO', Icons.check_circle_rounded, AppColors.success, '15 min ago'),
    ];

    return AppCard(
      title: 'Recent Activities',
      subtitle: 'Latest actions across all colleges',
      trailing: TextButton(onPressed: () {}, child: Text('View All', style: AppTypography.buttonSmall.copyWith(color: AppColors.accent))),
      child: Column(
        children: activities.map((a) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(width: 36, height: 36, decoration: BoxDecoration(color: a.color.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusMd), child: Icon(a.icon, size: 18, color: a.color)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(a.title, style: AppTypography.labelLarge),
              const SizedBox(height: 2),
              Text(a.description, style: AppTypography.caption),
            ])),
            Text(a.time, style: AppTypography.caption),
          ]),
        )).toList(),
      ),
    );
  }

  Widget _buildPendingTasks() {
    final tasks = [
      _Task('Review indent #1025', 'Store', AppColors.warning, 'High'),
      _Task('Approve salary structure', 'HR', AppColors.error, 'Urgent'),
    ];

    return AppCard(
      title: 'Pending Tasks',
      subtitle: '${tasks.length} items need attention',
      child: Column(
        children: tasks.map((t) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.surfaceVariant.withValues(alpha: 0.5), borderRadius: AppSpacing.borderRadiusMd, border: Border(left: BorderSide(color: t.color, width: 3))),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(t.title, style: AppTypography.labelLarge),
              const SizedBox(height: 2),
              Text(t.module, style: AppTypography.caption),
            ])),
            StatusBadge.priority(t.priority),
          ]),
        )).toList(),
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      _QuickAction('Add Student', Icons.person_add_rounded, AppColors.accent),
      _QuickAction('Create Indent', Icons.add_shopping_cart_rounded, AppColors.success),
      _QuickAction('Send Notice', Icons.campaign_rounded, AppColors.secondary),
      _QuickAction('Generate Report', Icons.assessment_rounded, AppColors.info),
      _QuickAction('Manage Users', Icons.manage_accounts_rounded, AppColors.primary),
      _QuickAction('View Logs', Icons.history_rounded, AppColors.textSecondary),
    ];

    return AppCard(
      title: 'Quick Actions',
      subtitle: 'Frequently used operations',
      child: GridView.count(
        shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.2,
        children: actions.map((a) => Material(
          color: Colors.transparent, borderRadius: AppSpacing.borderRadiusMd,
          child: InkWell(
            onTap: () {}, borderRadius: AppSpacing.borderRadiusMd,
            child: Container(
              decoration: BoxDecoration(color: a.color.withValues(alpha: 0.06), borderRadius: AppSpacing.borderRadiusMd, border: Border.all(color: a.color.withValues(alpha: 0.15))),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(width: 40, height: 40, decoration: BoxDecoration(color: a.color.withValues(alpha: 0.1), shape: BoxShape.circle), child: Icon(a.icon, size: 20, color: a.color)),
                const SizedBox(height: 8),
                Text(a.label, style: AppTypography.labelSmall.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
              ]),
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildUpcomingEvents() {
    final events = [
      _Event('Faculty Meeting', 'Mar 28, 10:00 AM', Icons.groups_rounded, AppColors.accent),
      _Event('Semester Exam Starts', 'Apr 5, 9:00 AM', Icons.quiz_rounded, AppColors.error),
    ];

    return AppCard(
      title: 'Upcoming Events',
      subtitle: 'Scheduled activities',
      child: Column(
        children: events.map((e) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(children: [
            Container(width: 44, height: 44, decoration: BoxDecoration(color: e.color.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusMd), child: Icon(e.icon, size: 20, color: e.color)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(e.title, style: AppTypography.labelLarge),
              const SizedBox(height: 2),
              Text(e.date, style: AppTypography.caption),
            ])),
          ]),
        )).toList(),
      ),
    );
  }

  Widget _buildSystemAlerts() {
    return AppCard(
      title: 'System Alerts',
      subtitle: 'Health warnings and notices',
      child: Column(children: [
        _buildAlertItem('Database backup completed', 'Last backup: 2 hours ago', Icons.cloud_done_rounded, AppColors.success),
        const SizedBox(height: 8),
        _buildAlertItem('Scheduled maintenance', 'March 30, 2:00 AM - 4:00 AM IST', Icons.engineering_rounded, AppColors.info),
      ]),
    );
  }

  Widget _buildAlertItem(String title, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.05), borderRadius: AppSpacing.borderRadiusMd, border: Border.all(color: color.withValues(alpha: 0.15))),
      child: Row(children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: AppTypography.labelLarge),
          Text(subtitle, style: AppTypography.caption),
        ])),
      ]),
    );
  }

  Widget _buildCollegeOverview() {
    final colleges = [
      _CollegeStats('College of Engineering', 1240, 85, 91.2, AppColors.accent),
      _CollegeStats('College of Medicine', 1100, 71, 94.5, AppColors.success),
    ];

    return AppCard(
      title: 'Institution Overview',
      subtitle: 'Performance across colleges',
      child: Column(
        children: colleges.map((c) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(children: [
            Container(width: 40, height: 40, decoration: BoxDecoration(color: c.color.withValues(alpha: 0.1), borderRadius: AppSpacing.borderRadiusMd), child: Icon(Icons.apartment_rounded, size: 20, color: c.color)),
            const SizedBox(width: 14),
            Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(c.name, style: AppTypography.labelLarge),
              Text('${c.students} students  |  ${c.staff} staff', style: AppTypography.caption),
            ])),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text('${c.attendance}%', style: AppTypography.metricSmall.copyWith(color: c.color, fontSize: 16)),
              Text('Attendance', style: AppTypography.caption),
            ])),
          ]),
        )).toList(),
      ),
    );
  }
}

class _MetricData {
  final String label, value, trend;
  final IconData icon;
  final Color iconColor, iconBgColor;
  final bool trendUp;
  const _MetricData(this.label, this.value, this.icon, this.iconColor, this.iconBgColor, this.trend, this.trendUp);
}

class _Activity {
  final String title, description, time;
  final IconData icon;
  final Color color;
  const _Activity(this.title, this.description, this.icon, this.color, this.time);
}

class _Task {
  final String title, module, priority;
  final Color color;
  const _Task(this.title, this.module, this.color, this.priority);
}

class _QuickAction {
  final String label;
  final IconData icon;
  final Color color;
  const _QuickAction(this.label, this.icon, this.color);
}

class _Event {
  final String title, date;
  final IconData icon;
  final Color color;
  const _Event(this.title, this.date, this.icon, this.color);
}

class _CollegeStats {
  final String name;
  final int students, staff;
  final double attendance;
  final Color color;
  const _CollegeStats(this.name, this.students, this.staff, this.attendance, this.color);
}
