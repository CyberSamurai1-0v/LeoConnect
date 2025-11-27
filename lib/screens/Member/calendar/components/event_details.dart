import 'package:flutter/material.dart';
import 'package:leo_connect/config/colors.dart';

import '../../../../models/calendar_event.dart';

class EventDetailsModal extends StatefulWidget {
  final CalendarEvent event;
  const EventDetailsModal({super.key, required this.event});

  @override
  State<EventDetailsModal> createState() => _EventDetailsModalState();
}

class _EventDetailsModalState extends State<EventDetailsModal> {
  String _rsvpStatus = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.cardPrimaryText.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Title
            Text(
              widget.event.title,
              style: TextStyle(
                color: AppColors.cardHeadingText,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            // Description
            Text(
              widget.event.description,
              style: TextStyle(
                color: AppColors.cardPrimaryText,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            // Date info
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: AppColors.iconColor,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.event.formattedDate,
                  style: const TextStyle(
                    color: AppColors.cardPrimaryText,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Location info
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppColors.iconColor,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.event.location,
                  style: const TextStyle(
                    color: AppColors.cardPrimaryText,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Attendance toggle
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.eventCardBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Will you be there',
                    style: TextStyle(
                      color: AppColors.cardHeadingText,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildRsvpButton("Yes", "yes"),
                      _buildRsvpButton("No", "no"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRsvpButton(String label, String value) {
    final bool isSelected = _rsvpStatus == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _rsvpStatus = value;
          });

          // TODO: Send RSVP to backend
          // ApiService.post("/events/rsvp", {...})
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.cardSecondaryText
                : AppColors.eventCardBackground,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? AppColors.cardSecondaryText
                  : AppColors.cardPrimaryText,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? AppColors.background
                    : AppColors.cardHeadingText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
