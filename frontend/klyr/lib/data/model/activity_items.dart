class ActivityItem {
  const ActivityItem({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    this.isHighlighted = false,
  });
  final int id;
  final String title;
  final String date;
  final String amount;
  final bool isHighlighted;
}
