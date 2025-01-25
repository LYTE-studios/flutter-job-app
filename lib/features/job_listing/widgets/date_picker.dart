import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePickerBottomSheet extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final ValueChanged<DateTime> onDateSelected;

  const CustomDatePickerBottomSheet({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _CustomDatePickerBottomSheetState createState() =>
      _CustomDatePickerBottomSheetState();
}

class _CustomDatePickerBottomSheetState
    extends State<CustomDatePickerBottomSheet> {
  late DateTime tempSelectedDate;

  @override
  void initState() {
    super.initState();
    tempSelectedDate = widget.startDate;
  }

  void _showMonthSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: 12,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final month = DateTime(2020, index + 1, 1);
              final isSelected = tempSelectedDate.month == index + 1;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    tempSelectedDate = DateTime(
                      tempSelectedDate.year,
                      index + 1,
                      tempSelectedDate.day,
                    );
                  });
                  Navigator.pop(context);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isSelected ? Colors.tealAccent : Colors.grey[800],
                    boxShadow: [
                      if (isSelected)
                        BoxShadow(
                          color: Colors.tealAccent.withOpacity(0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    DateFormat('MMM').format(month),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.grey[300],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showYearSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final currentYear = DateTime.now().year;
        return Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              final year = currentYear + index;
              final isSelected = tempSelectedDate.year == year;
              return ListTile(
                title: Text(
                  '$year',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.tealAccent : Colors.white,
                  ),
                ),
                onTap: () {
                  setState(() {
                    tempSelectedDate = DateTime(
                      year,
                      tempSelectedDate.month,
                      tempSelectedDate.day,
                    );
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E1E2C), Color(0xFF2C2C38)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              height: 4,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selected Date: ${DateFormat('d MMM yyyy').format(tempSelectedDate)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.tealAccent,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: _showMonthSelector,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            DateFormat('MMM').format(tempSelectedDate),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.tealAccent,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.tealAccent,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _showYearSelector,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${tempSelectedDate.year}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.tealAccent,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.tealAccent,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Divider(color: Colors.grey, thickness: 1, height: 24),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Mon",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                Text("Tue",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                Text("Wed",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                Text("Thu",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                Text("Fri",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                Text("Sat",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                Text("Sun",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount:
                  DateTime(tempSelectedDate.year, tempSelectedDate.month + 1, 0)
                          .day +
                      DateTime(tempSelectedDate.year, tempSelectedDate.month, 1)
                          .weekday -
                      1,
              itemBuilder: (context, index) {
                final firstWeekday =
                    DateTime(tempSelectedDate.year, tempSelectedDate.month, 1)
                        .weekday;
                final day = index - (firstWeekday - 2);

                if (index < firstWeekday - 1) {
                  // Empty cells for days of the previous month
                  return const SizedBox();
                }

                final date = DateTime(
                    tempSelectedDate.year, tempSelectedDate.month, day);
                final isSelected = tempSelectedDate.day == day;

                return GestureDetector(
                  onTap: () {
                    if (day > 0) {
                      setState(() {
                        tempSelectedDate = date;
                      });
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: isSelected ? Colors.teal : Colors.transparent,
                      border: Border.all(
                        color: isSelected ? Colors.teal : Colors.grey.shade800,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      day > 0 ? '$day' : '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.grey[300],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(color: Colors.grey[700], thickness: 2, height: 24),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent.withOpacity(0.8),
                    shadowColor: Colors.redAccent,
                    elevation: 4,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "CANCEL",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onDateSelected(tempSelectedDate);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                    shadowColor: Colors.tealAccent,
                    elevation: 4,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
