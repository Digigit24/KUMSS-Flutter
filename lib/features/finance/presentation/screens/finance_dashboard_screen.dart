import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/theme/theme_exports.dart';
import '../../../../core/widgets/widget_exports.dart';

class FinanceDashboardScreen extends StatelessWidget {
  const FinanceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Finance Dashboard',
            subtitle: 'Financial overview and analytics',
            breadcrumbs: ['Home', 'Finance', 'Dashboard'],
          ),
          // Metrics
          Row(
            children: [
              Expanded(child: MetricCard(label: 'Total Revenue', value: '\u20B9 4.2 Cr', icon: Icons.trending_up_rounded, iconColor: AppColors.success, iconBgColor: AppColors.successSurface, trend: '+12.5%', trendUp: true)),
              const SizedBox(width: 16),
              Expanded(child: MetricCard(label: 'Total Expenses', value: '\u20B9 2.8 Cr', icon: Icons.trending_down_rounded, iconColor: AppColors.error, iconBgColor: AppColors.errorSurface, trend: '+5.2%', trendUp: false)),
              const SizedBox(width: 16),
              Expanded(child: MetricCard(label: 'Net Income', value: '\u20B9 1.4 Cr', icon: Icons.account_balance_wallet_rounded, iconColor: AppColors.accent, iconBgColor: AppColors.accentSurface, trend: '+18.3%', trendUp: true)),
              const SizedBox(width: 16),
              Expanded(child: MetricCard(label: 'Fee Collection', value: '87.4%', icon: Icons.receipt_long_rounded, iconColor: AppColors.secondary, iconBgColor: AppColors.secondarySurface, trend: '+2.1%', trendUp: true)),
            ],
          ),
          const SizedBox(height: 24),
          // Chart
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: AppCard(
                  title: 'Revenue vs Expenses',
                  subtitle: 'Monthly comparison',
                  child: SizedBox(
                    height: 280,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          horizontalInterval: 10,
                          getDrawingHorizontalLine: (value) => FlLine(color: AppColors.border, strokeWidth: 1, dashArray: [4, 4]),
                          drawVerticalLine: false,
                        ),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, _) {
                            const m = ['A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D', 'J', 'F', 'M'];
                            if (v.toInt() >= 0 && v.toInt() < m.length) return Padding(padding: const EdgeInsets.only(top: 8), child: Text(m[v.toInt()], style: AppTypography.caption));
                            return const SizedBox();
                          })),
                          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40, interval: 10, getTitlesWidget: (v, _) => Text('${v.toInt()}L', style: AppTypography.caption))),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: [FlSpot(0, 35), FlSpot(1, 42), FlSpot(2, 28), FlSpot(3, 38), FlSpot(4, 45), FlSpot(5, 40), FlSpot(6, 52), FlSpot(7, 48), FlSpot(8, 35), FlSpot(9, 55), FlSpot(10, 50), FlSpot(11, 42)],
                            isCurved: true,
                            color: AppColors.accent,
                            barWidth: 2.5,
                            dotData: const FlDotData(show: false),
                            belowBarData: BarAreaData(show: true, color: AppColors.accent.withValues(alpha: 0.08)),
                          ),
                          LineChartBarData(
                            spots: [FlSpot(0, 22), FlSpot(1, 28), FlSpot(2, 20), FlSpot(3, 25), FlSpot(4, 30), FlSpot(5, 26), FlSpot(6, 35), FlSpot(7, 32), FlSpot(8, 24), FlSpot(9, 38), FlSpot(10, 34), FlSpot(11, 28)],
                            isCurved: true,
                            color: AppColors.error,
                            barWidth: 2.5,
                            dotData: const FlDotData(show: false),
                            belowBarData: BarAreaData(show: true, color: AppColors.error.withValues(alpha: 0.05)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: AppCard(
                  title: 'Top Fee Defaulters',
                  subtitle: 'Students with pending fees',
                  child: Column(
                    children: [
                      _buildDefaulterItem('Ravi Kumar', 'B.Tech CSE', '\u20B945,000'),
                      _buildDefaulterItem('Anita Sharma', 'MBA', '\u20B938,000'),
                      _buildDefaulterItem('Deepak Jha', 'MBBS', '\u20B952,000'),
                      _buildDefaulterItem('Sunita Rao', 'LLB', '\u20B928,000'),
                      _buildDefaulterItem('Manoj Tiwari', 'B.Sc', '\u20B922,000'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDefaulterItem(String name, String program, String amount) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: AppColors.errorSurface, borderRadius: AppSpacing.borderRadiusMd),
            child: Center(child: Text(name[0], style: AppTypography.labelMedium.copyWith(color: AppColors.error))),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: AppTypography.labelLarge),
            Text(program, style: AppTypography.caption),
          ])),
          Text(amount, style: AppTypography.labelMedium.copyWith(color: AppColors.error, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
