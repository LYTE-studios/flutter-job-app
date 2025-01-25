import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateTimePicker extends StatefulWidget {
  final void Function(DateTime, TimeOfDay) onDateTimeSelected;

  const CustomDateTimePicker({
    super.key,
    required this.onDateTimeSelected,
  });

  @override
  State<CustomDateTimePicker> createState() => CustomDateTimePickerState();
}

class CustomDateTimePickerState extends State<CustomDateTimePicker> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isAm = true;
  bool showMonthSelector = false;

  // Format time without AM/PM
  String formatTimeWithoutAmPm(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    return '${hour == 0 ? 12 : hour}  :  $minute';
  }

  // Add this helper method to calculate total days to show
  List<DateTime> _calculateDaysInMonth(DateTime date) {
    final DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    final int firstWeekday = firstDayOfMonth.weekday % 7;
    final List<DateTime> days = [];

    // Add days from previous month
    final DateTime previousMonth = DateTime(date.year, date.month - 1);
    final int daysInPreviousMonth = DateTime(date.year, date.month, 0).day;
    for (int i = daysInPreviousMonth - firstWeekday + 1;
        i <= daysInPreviousMonth;
        i++) {
      days.add(DateTime(previousMonth.year, previousMonth.month, i));
    }

    // Add days from current month
    final int daysInMonth = DateTime(date.year, date.month + 1, 0).day;
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(date.year, date.month, i));
    }

    // Add days from next month
    final int remainingDays = 42 - days.length; // 6 weeks × 7 days = 42
    for (int i = 1; i <= remainingDays; i++) {
      days.add(DateTime(date.year, date.month + 1, i));
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    // Show the picker UI directly
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: StatefulBuilder(
        builder: (context, setModalState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: GestureDetector(
                      onTap: () {
                        setModalState(() {
                          showMonthSelector = !showMonthSelector;
                        });
                      },
                      child: showMonthSelector
                          ? Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.pink,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Back',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.pink,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    DateFormat('yyyy').format(selectedDate),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Text(
                                  DateFormat('MMM yyyy').format(selectedDate),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  color: Colors.pink,
                                  size: 20,
                                ),
                              ],
                            ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.pink,
                              size: 20,
                            ),
                            onPressed: () {
                              setModalState(() {
                                selectedDate = DateTime(
                                  selectedDate.year,
                                  selectedDate.month - 1,
                                  selectedDate.day,
                                );
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.pink,
                              size: 20,
                            ),
                            onPressed: () {
                              setModalState(() {
                                selectedDate = DateTime(
                                  selectedDate.year,
                                  selectedDate.month + 1,
                                  selectedDate.day,
                                );
                              });
                            },
                          ),
                        ],
                      ))
                ],
              ),

              const SizedBox(height: 8),

              if (showMonthSelector)
                _buildMonthSelector(setModalState)
              else
                _buildCalendarView(setModalState),
              Divider(
                color: Color(0xFFF0F3F7),
                thickness: 1.8,
              ),
              const SizedBox(height: 16),

              // Time Selector Section
              _buildTimeSelector(setModalState),

              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMonthSelector(StateSetter setModalState) {
    final months = List.generate(12, (index) => index + 1);
    final currentMonth = DateTime.now().month;

    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          itemCount: 12,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2,
          ),
          itemBuilder: (context, index) {
            final month = months[index];
            final isSelected = selectedDate.month == month;
            final isCurrentMonth = currentMonth == month;

            return GestureDetector(
              onTap: () {
                setModalState(() {
                  selectedDate = DateTime(
                    selectedDate.year,
                    month,
                    selectedDate.day,
                  );
                  showMonthSelector = false;
                });
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFFF4F5FF) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  DateFormat('MMM').format(DateTime(0, month)),
                  style: TextStyle(
                    color: isSelected
                        ? Colors.pinkAccent
                        : isCurrentMonth
                            ? Colors.pink
                            : Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCalendarView(StateSetter setModalState) {
    final days = _calculateDaysInMonth(selectedDate);
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 35, // 6 weeks × 7 days
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final currentDate = days[index];

        final bool isCurrentMonth = currentDate.month == selectedDate.month;
        final bool isToday = currentDate.year == DateTime.now().year &&
            currentDate.month == DateTime.now().month &&
            currentDate.day == DateTime.now().day;
        final bool isSelected = currentDate.year == selectedDate.year &&
            currentDate.month == selectedDate.month &&
            currentDate.day == selectedDate.day;

        return GestureDetector(
          onTap: () {
            if (isCurrentMonth) {
              setModalState(() {
                selectedDate = currentDate;
              });
              // Only call onDateTimeSelected when a day is clicked
              widget.onDateTimeSelected(selectedDate, selectedTime);
            }
          },
          child: Container(
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.pink
                  : isToday
                      ? Color(0xFFBCCAD9)
                      : Colors.transparent,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              "${currentDate.day}",
              style: TextStyle(
                fontSize: 16,
                color: isSelected
                    ? Colors.white
                    : isToday
                        ? Colors.black
                        : isCurrentMonth
                            ? Colors.grey.shade800
                            : Colors.grey.shade300,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimeSelector(StateSetter setModalState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Time",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (picked != null) {
                  setModalState(() {
                    selectedTime = picked;
                    isAm = selectedTime.period == DayPeriod.am;
                  });
                  // Removed widget.onDateTimeSelected call
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                decoration: BoxDecoration(
                  color: Color(0xFFF0F3F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  formatTimeWithoutAmPm(selectedTime),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Color(0xFFF0F3F7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  for (final period in ['AM', 'PM'])
                    GestureDetector(
                      onTap: () {
                        setModalState(() {
                          isAm = period == 'AM';
                          int currentHour = selectedTime.hour % 12;
                          if (currentHour == 0) currentHour = 12;
                          final newHour = isAm
                              ? (currentHour == 12 ? 0 : currentHour)
                              : (currentHour == 12 ? 12 : currentHour + 12);
                          selectedTime = TimeOfDay(
                            hour: newHour,
                            minute: selectedTime.minute,
                          );
                        });
                        // Removed widget.onDateTimeSelected call
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: (isAm && period == 'AM') ||
                                  (!isAm && period == 'PM')
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          period,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
