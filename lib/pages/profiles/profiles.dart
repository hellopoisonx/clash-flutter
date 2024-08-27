import 'package:clash_flutter/providers/profiles/profiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilesPage extends ConsumerWidget {
  const ProfilesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiles = ref.watch(profilesProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: ref.read(profilesProvider.notifier).importFromLocal,
            child: const Text("Local"),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: profiles.all.length,
        itemBuilder: (context, idx) {
          final profile = profiles.all[idx];
          return Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            decoration: BoxDecoration(
              boxShadow: [
                profile.path == profiles.currentProfilePath
                    ? const BoxShadow(blurRadius: 5, color: Colors.orange)
                    : const BoxShadow(blurRadius: 2)
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: 90,
            child: ListTile(
                onTap: profile.path == profiles.currentProfilePath
                    ? null
                    : () => ref
                        .read(profilesProvider.notifier)
                        .switchProfile(profile.path),
                title: Text(
                  profile.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  profile.path,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium,
                )),
          );
        },
      ),
    );
  }
}
