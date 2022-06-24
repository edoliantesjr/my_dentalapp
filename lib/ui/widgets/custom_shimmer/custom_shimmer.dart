import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 18),
          height: 130,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Palettes.kcNeutral6),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(color: Palettes.kcNeutral4, blurRadius: 1)
              ]),
          child: Row(
            children: [
              SkeletonLoader(
                loading: true,
                startColor: Colors.grey.shade300,
                endColor: Colors.grey.shade200,
                child: const SizedBox(
                  width: 70,
                  height: 100,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SkeletonLoader(
                      loading: true,
                      startColor: Colors.grey.shade400,
                      endColor: Colors.grey.shade200,
                      child: const SizedBox(
                        height: 14,
                        width: 100,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SkeletonLoader(
                      loading: true,
                      startColor: Colors.grey.shade400,
                      endColor: Colors.grey.shade200,
                      child: const SizedBox(
                        height: 14,
                        width: 100,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SkeletonLoader(
                      loading: true,
                      startColor: Colors.grey.shade400,
                      endColor: Colors.grey.shade200,
                      child: const SizedBox(
                        height: 14,
                        width: 100,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SkeletonLoader(
                      loading: true,
                      startColor: Colors.grey.shade400,
                      endColor: Colors.grey.shade200,
                      child: const SizedBox(
                        height: 14,
                        width: 100,
                      ),
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
