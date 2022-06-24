class NotificationToken {
  final dynamic uid;
  final dynamic tokenId;

  const NotificationToken({
    required this.uid,
    required this.tokenId,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'tokenId': tokenId,
    };
  }

  factory NotificationToken.fromJson(Map<String, dynamic> map) {
    return NotificationToken(
      uid: map['uid'] as dynamic,
      tokenId: map['tokenId'] as dynamic,
    );
  }
}
