class BPAppBarConfig {
  final String title;
  final List<Map<String, dynamic>> actionButton;

  BPAppBarConfig({required this.title, required this.actionButton});

  Map<String, dynamic> toJson() {
    return {
       'title': title, 'actionBUtton': actionButton
    };
  }
}
