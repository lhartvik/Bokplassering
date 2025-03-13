class Cicerobok {
  final String recordId;
  final String title;
  final String locLabel;
  final String locRaw;
  final int available;
  final String branchcode;
  final String status;

  Cicerobok(
      {required this.recordId,
      required this.title,
      required this.locLabel,
      required this.locRaw,
      required this.available,
      required this.branchcode,
      required this.status});

  @override
  String toString() {
    return 'Cicerobok(recordId: $recordId, title: $title, locLabel: $locLabel, locRaw: $locRaw, available: $available, branchcode: $branchcode, status: $status)';
  }
}
