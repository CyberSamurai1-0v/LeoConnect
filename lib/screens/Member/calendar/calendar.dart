import 'package:flutter/material.dart';
import 'package:leo_connect/config/colors.dart';
import '../../../models/calendar_event.dart';
import 'components/event_card.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late DateTime _selectedMonth;
  late int _selectedDay;

  late Future<List<CalendarEvent>> eventsFuture;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedMonth = DateTime(now.year, now.month);
    _selectedDay = now.day;

    // Fetch events
    eventsFuture = CalendarEvent.fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CalendarEvent>>(
      future: eventsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: Text(
                'Failed to load events: ${snapshot.error}',
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          );
        }

        final eventsList = snapshot.data ?? [];

        // Events for selected day
        final eventsForSelectedDay = eventsList
            .where(
              (e) =>
                  e.date.year == _selectedMonth.year &&
                  e.date.month == _selectedMonth.month &&
                  e.date.day == _selectedDay,
            )
            .toList();

        // Days in this month with events
        final eventDays = eventsList
            .where(
              (e) =>
                  e.date.year == _selectedMonth.year &&
                  e.date.month == _selectedMonth.month,
            )
            .map((e) => e.date.day)
            .toSet();

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'Events & Activities',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                // Calendar
                _buildCalendar(Colors.black26, eventDays),
                const SizedBox(height: 20),
                // Events list for selected day
                Expanded(
                  child: eventsForSelectedDay.isEmpty
                      ? Center(
                          child: Text(
                            'No events on $_selectedDay ${_getMonthName(_selectedMonth.month)}',
                            style: const TextStyle(color: Colors.white54),
                          ),
                        )
                      : ListView.separated(
                          itemCount: eventsForSelectedDay.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final event = eventsForSelectedDay[index];
                            return EventCard(
                              event: event,
                              backgroundColor: AppColors.eventCardBackground,
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCalendar(Color cardBg, Set<int> eventDays) {
    final firstDayOfMonth = DateTime(
      _selectedMonth.year,
      _selectedMonth.month,
      1,
    );
    final lastDayOfMonth = DateTime(
      _selectedMonth.year,
      _selectedMonth.month + 1,
      0,
    );
    final daysInMonth = lastDayOfMonth.day;
    final firstWeekday = firstDayOfMonth.weekday;

    final days = <int?>[
      ...List<int?>.filled(firstWeekday - 1, null),
      ...List<int>.generate(daysInMonth, (i) => i + 1),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.yellow[700]!, width: 2),
      ),
      child: Column(
        children: [
          // Month header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: _previousMonth,
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.yellow[700],
                  size: 28,
                ),
              ),
              Text(
                '${_getMonthName(_selectedMonth.month)} ${_selectedMonth.year}',
                style: TextStyle(
                  color: Colors.yellow[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                onTap: _nextMonth,
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.yellow[700],
                  size: 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Weekday headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _WeekdayHeader('M'),
              _WeekdayHeader('T'),
              _WeekdayHeader('W'),
              _WeekdayHeader('T'),
              _WeekdayHeader('F'),
              _WeekdayHeader('S'),
              _WeekdayHeader('S'),
            ],
          ),
          const SizedBox(height: 10),
          // Calendar grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemCount: days.length,
            itemBuilder: (context, index) {
              final day = days[index];
              if (day == null) return const SizedBox();
              final isSelected = day == _selectedDay;
              final hasEvent = eventDays.contains(day);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDay = day;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? Colors.yellow[700]
                            : Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        day.toString(),
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white70,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                    if (hasEvent)
                      Container(
                        width: 20,
                        height: 2,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.yellow[700],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  void _previousMonth() {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
      _selectedDay = 1;
    });
  }

  void _nextMonth() {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
      _selectedDay = 1;
    });
  }
}

class _WeekdayHeader extends StatelessWidget {
  final String label;
  const _WeekdayHeader(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.white54,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
