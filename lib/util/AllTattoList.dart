class AllTattoList {
  final int scarId;
  final String tattooImage; //uri

  const AllTattoList({
    required this.scarId,
    required this.tattooImage,
  });

  factory AllTattoList.fromJson(Map<String, dynamic> json) {
    return AllTattoList(
        scarId: json['scarId'],
        tattooImage: json['tattooImage'],
    );
  }
}