import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:iihf_template/components/visual.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class GWGChart extends StatefulWidget {
  const GWGChart({super.key});

  @override
  State<GWGChart> createState() => _GWGChartState();
}

class _GWGChartState extends State<GWGChart> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  void initState() {
    loadAsset();
    data = [
      _ChartData('Simon Knak', 2),
      _ChartData('Kasper Simontaival', 4),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(minimum: 0, maximum: 6, interval: 1),
        tooltipBehavior: _tooltip,
        series: <ChartSeries<_ChartData, String>>[
          BarSeries<_ChartData, String>(
              dataSource: data,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              name: 'Game winning goals',
              color: const Color.fromARGB(255, 15, 148, 209))
        ]);
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
