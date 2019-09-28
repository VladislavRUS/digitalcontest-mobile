import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final bool isLocal;
  final String imageUrl;
  final String title;
  final Widget bottomRow;
  final Function onTap;

  ListItem(this.isLocal, this.imageUrl, this.title, this.bottomRow,
      {this.onTap});

  Widget buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
          height: 200,
          child: isLocal
              ? Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                )
              : Hero(
                  tag: imageUrl,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              imageUrl != null ? buildImage() : null,
              Container(
                margin: EdgeInsets.only(bottom: 10, top: 10),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
              bottomRow
            ].where((widget) => widget != null).toList(),
          ),
        ),
      ),
    );
  }
}
