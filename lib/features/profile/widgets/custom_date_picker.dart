import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final double itemExtent;
  final Function(DateTime?)? onChanged;
  final Color? selectorColor;
  final TextStyle? textStyle;
  final TextStyle? selectedTextStyle;

  const CustomDatePicker({
    super.key,
    this.initialDate,
    this.onChanged,
    this.itemExtent = 40,
    this.selectorColor,
    this.textStyle,
    this.selectedTextStyle,
  });

  @override
  CustomDatePickerState createState() => CustomDatePickerState();
}

class CustomDatePickerState extends State<CustomDatePicker> {
  late int selectedDay;
  late int selectedMonth;
  late int selectedYear;
  late FixedExtentScrollController dayScrollController;
  late FixedExtentScrollController monthScrollController;
  late FixedExtentScrollController yearScrollController;

  static const int yearRange = 100;
  final List<String> monthNames = [
    'Januari',
    'Februari',
    'Maart',
    'April',
    'Kunnen',
    'Juni',
    'Juli',
    'Augustus',
    'September',
    'Oktober',
    'November',
    'December',
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedDay = widget.initialDate?.day ?? now.day;
    selectedMonth = widget.initialDate?.month ?? now.month;
    selectedYear = widget.initialDate?.year ?? now.year;

    dayScrollController =
        FixedExtentScrollController(initialItem: selectedDay - 1);
    monthScrollController =
        FixedExtentScrollController(initialItem: selectedMonth - 1);
    yearScrollController = FixedExtentScrollController(
        initialItem: selectedYear - (now.year - yearRange ~/ 2));
  }

  void _onDayChanged(int day) {
    setState(() {
      selectedDay = day + 1;
      _updateSelectedDate();
    });
  }

  void _onMonthChanged(int month) {
    setState(() {
      selectedMonth = month + 1;
      _updateSelectedDate();
    });
  }

  void _onYearChanged(int yearIndex) {
    final currentYear = DateTime.now().year;
    setState(() {
      selectedYear = currentYear - (yearRange ~/ 2) + yearIndex;
      _updateSelectedDate();
    });
  }

  void _updateSelectedDate() {
    final updatedDate = DateTime(
      selectedYear,
      selectedMonth,
      selectedDay,
    );
    widget.onChanged?.call(updatedDate);
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(selectedYear, selectedMonth + 1, 0).day;
    if (selectedDay > daysInMonth) {
      selectedDay = daysInMonth;
      dayScrollController.jumpToItem(selectedDay - 1);
    }

    final defaultTextStyle = widget.textStyle ??
        const TextStyle(
          fontSize: 20.3,
          color: Colors.grey,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        );
    final selectedTextStyle = widget.selectedTextStyle ??
        const TextStyle(
          fontSize: 20.3,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        );

    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: Center(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: widget.selectorColor ?? Colors.grey.withOpacity(0.1),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const Spacer(),
            _buildListWheel(
              dayScrollController,
              daysInMonth,
              (index) => '${index + 1}',
              _onDayChanged,
              defaultTextStyle,
              selectedTextStyle,
              width: 60,
            ),
            const Spacer(),
            _buildListWheel(
              monthScrollController,
              12,
              (index) => monthNames[index],
              _onMonthChanged,
              defaultTextStyle,
              selectedTextStyle,
              width: 100,
            ),
            const Spacer(),
            _buildListWheel(
              yearScrollController,
              yearRange,
              (index) {
                final currentYear = DateTime.now().year;
                return (currentYear - (yearRange ~/ 2) + index).toString();
              },
              _onYearChanged,
              defaultTextStyle,
              selectedTextStyle,
              width: 80,
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }

  Widget _buildListWheel(
    FixedExtentScrollController controller,
    int itemCount,
    String Function(int index) labelBuilder,
    Function(int index) onSelectedItemChanged,
    TextStyle defaultTextStyle,
    TextStyle selectedTextStyle, {
    double width = 60,
    double itemExtent = 40,
  }) {
    return SizedBox(
      width: width,
      height: itemExtent * 3,
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey,
              Colors.transparent,
              Colors.transparent,
              Colors.grey,
            ],
            stops: [0.0, 0.1, 0.9, 1.0],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: ListWheelScrollView.useDelegate(
          controller: controller,
          itemExtent: itemExtent,
          physics: const FixedExtentScrollPhysics(),
          overAndUnderCenterOpacity: 0.5,
          perspective: 0.0005,
          onSelectedItemChanged: onSelectedItemChanged,
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) {
              final isSelected = controller.selectedItem == index;
              return Center(
                child: FittedBox(
                  child: Text(
                    labelBuilder(index),
                    style: isSelected ? selectedTextStyle : defaultTextStyle,
                  ),
                ),
              );
            },
            childCount: itemCount,
          ),
        ),
      ),
    );
  }
}
