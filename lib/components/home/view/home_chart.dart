import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sprout_mobile/utils/app_colors.dart';

class HomeChart extends StatefulWidget {
  const HomeChart(
      {super.key,
      required this.color,
      required this.graph,
      required this.maxY});

  final Color color;
  final dynamic graph;
  final double maxY;

  @override
  State<HomeChart> createState() => _HomeChartState();
}

class _HomeChartState extends State<HomeChart> {
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(
              decoration: BoxDecoration(
                  color: isDarkMode ? AppColors.black : AppColors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: LineChart(
                  mainData(),
                ),
              )),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 8,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text(widget.graph['dates'][0], style: style);
        break;
      case 2:
        text = Text(widget.graph['dates'][1], style: style);
        break;
      case 3:
        text = Text(widget.graph['dates'][2], style: style);
        break;
      case 4:
        text = Text(widget.graph['dates'][3], style: style);
        break;
      case 5:
        text = Text(widget.graph['dates'][4], style: style);
        break;
      case 6:
        text = Text(widget.graph['dates'][5], style: style);
        break;
      case 7:
        text = Text(widget.graph['dates'][6], style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 8,
    );
    return Text("*", style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: widget.graph['interval'],
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 15,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 1,
      maxX: 7,
      minY: 0,
      maxY: widget.maxY,
      lineBarsData: [
        LineChartBarData(
          spots: widget.graph['spots'],
          isCurved: true,
          color: widget.color,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            color: isDarkMode ? AppColors.black : AppColors.white,
          ),
        ),
      ],
    );
  }
}
