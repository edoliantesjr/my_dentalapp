import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentalapp/models/user_model/user_model.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final VoidCallback? onTap;
  final UserModel user;
  const UserCard({Key? key, this.onTap, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 154,
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: user.image,
            fit: BoxFit.cover,
            height: 80,
            width: 80,
          ),
          Text(user.fullName),
          Text(user.position),
        ],
      ),
    );
  }
}
