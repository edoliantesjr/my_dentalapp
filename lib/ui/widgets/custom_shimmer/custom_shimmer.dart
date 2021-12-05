import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

class MyShimmer extends StatelessWidget {
  final int? itemCount;
  const MyShimmer({Key? key, this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: itemCount ?? 3,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          height: 135,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Palettes.kcNeutral6),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Palettes.kcNeutral4, blurRadius: 1)
              ]),
          child: Row(
            children: [
              FadeShimmer(
                width: 70,
                height: 100,
                highlightColor: Colors.grey.shade100,
                millisecondsDelay: 0,
                baseColor: Colors.grey.shade400,
                radius: 15,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FadeShimmer(
                      height: 14,
                      width: 100,
                      highlightColor: Colors.grey.shade100,
                      millisecondsDelay: 0,
                      baseColor: Colors.grey.shade400,
                      radius: 2,
                    ),
                    SizedBox(height: 8),
                    FadeShimmer(
                      height: 14,
                      width: 100,
                      highlightColor: Colors.grey.shade100,
                      millisecondsDelay: 0,
                      baseColor: Colors.grey.shade400,
                      radius: 2,
                    ),
                    SizedBox(height: 8),
                    FadeShimmer(
                      height: 14,
                      width: 100,
                      highlightColor: Colors.grey.shade100,
                      millisecondsDelay: 0,
                      baseColor: Colors.grey.shade400,
                      radius: 2,
                    ),
                    SizedBox(height: 8),
                    FadeShimmer(
                      height: 14,
                      width: 100,
                      highlightColor: Colors.grey.shade100,
                      millisecondsDelay: 0,
                      baseColor: Colors.grey.shade400,
                      radius: 2,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
