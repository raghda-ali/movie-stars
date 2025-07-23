import 'package:flutter/material.dart';

class PopularPeoplePage extends StatelessWidget {
  const PopularPeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular People'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                '',
              ),
              onBackgroundImageError: (_, __) {},
            ),
            title: Text('Person Name'),
            subtitle: const Text('Actor'),
            onTap: () {
            },
          );
        },
      ),
    );
  }
}
