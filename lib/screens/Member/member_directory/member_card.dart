import 'package:flutter/material.dart';
import '../../../models/member.dart';
import 'avatar_ring.dart';

class MemberCard extends StatelessWidget {
  final Member member;
  final Color backgroundColor;
  const MemberCard({
    super.key,
    required this.member,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              AvatarWithRing(imageUrl: member.avatarUrl, size: 56),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      member.club,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      member.role,
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  PopupMenuButton<int>(
                    color: Colors.grey[900],
                    icon: const Icon(Icons.more_vert, color: Colors.white60),
                    itemBuilder: (_) => [
                      const PopupMenuItem(
                        value: 1,
                        child: Text(
                          'View',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        child: Text(
                          'Message',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
