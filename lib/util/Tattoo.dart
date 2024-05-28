class Tattoo {
  final String scarImage;
  final String segmentImage;
  final String tattooImage;
  final String synthesisImage;

  const Tattoo({
    required this.scarImage,
    required this.segmentImage,
    required this.tattooImage,
    required this.synthesisImage,
  });

  factory Tattoo.fromJson(Map<String, dynamic> json) {
    return Tattoo(
      scarImage: json['scarImage'],
      segmentImage: json['segmentImage'],
      tattooImage: json['tattooImage'],
      synthesisImage: json['synthesisImage']
    );
  }
}