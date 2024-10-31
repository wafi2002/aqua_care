class Report {
  final String name;
  final String address;
  final String issue;
  final String date;
  final String time;
  final String? imageUrl;
  final String userId; // New field for user ID

  Report({
    required this.name,
    required this.address,
    required this.issue,
    required this.date,
    required this.time,
    this.imageUrl,
    required this.userId, // Include user ID in constructor
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'issue': issue,
      'date': date,
      'time': time,
      'imageUrl': imageUrl,
      'userId': userId, // Add user ID to map
    };
  }
}
