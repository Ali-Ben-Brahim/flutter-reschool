// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../constans.dart';

class StorageInfoCard extends StatefulWidget {
  const StorageInfoCard({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.amountOfFiles,
    required this.numOfFiles,
  }) : super(key: key);

  @override
  State<StorageInfoCard> createState() => _StorageInfoCardState();
  final Widget title;
  final String svgSrc, amountOfFiles;
  final double? numOfFiles;
}

class _StorageInfoCardState extends State<StorageInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: defaultPadding),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: Image.asset(widget.svgSrc),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.title,
                  
                  Text(
                    "${widget.numOfFiles} Qté",
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: const Color.fromARGB(179, 86, 86, 86)),
                  ),
                ],
              ),
            ),
          ),
          Text(widget.amountOfFiles)
        ],
      ),
    );
  }
}
