class AllTattooList {
  final int scarId;
  final String tattooImage; //uri

  const AllTattooList({
    required this.scarId,
    required this.tattooImage,
  });

  factory AllTattooList.fromJson(Map<String, dynamic> json) {
    return AllTattooList(
        scarId: json['scarId'],
        tattooImage: json['tattooImage'],
    );
  }
}