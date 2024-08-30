import 'package:clash_flutter/providers/profiles/profiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilesPage extends ConsumerWidget {
  const ProfilesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiles = ref.watch(profilesProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: ref.read(profilesProvider.notifier).importFromLocal,
            child: const Text("Local"),
          ),
          TextButton(
            onPressed: () async {
              bool submitted = false;
              String? error;
              await showDialog(
                  context: context,
                  builder: (context) {
                    final controller = TextEditingController();
                    return AlertDialog(
                      title: const Text("Import From URL"),
                      content: error == null
                          ? submitted
                              ? const SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Center(
                                      child: CircularProgressIndicator()))
                              : TextField(
                                  controller: controller,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                )
                          : Text(error!),
                      actions: error == null
                          ? [
                              IconButton(
                                icon: const Icon(Icons.check_rounded),
                                onPressed: () async {
                                  submitted = true;
                                  (context as Element).markNeedsBuild();
                                  try {
                                    await ref
                                        .read(profilesProvider.notifier)
                                        .importFromURL(controller.text);
                                  } catch (e) {
                                    error = e.toString();
                                    (context).markNeedsBuild();
                                    return;
                                  }
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                              ),
                            ]
                          : null,
                    );
                  });
            },
            child: const Text("Url"),
          )
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          mainAxisExtent: 90,
        ),
        itemCount: profiles.all.length,
        itemBuilder: (context, idx) {
          final profile = profiles.all[idx];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            decoration: BoxDecoration(
              boxShadow: [
                profile.path == profiles.currentProfilePath
                    ? BoxShadow(
                        blurRadius: 5,
                        color: Theme.of(context).colorScheme.primaryContainer,
                      )
                    : const BoxShadow(blurRadius: 2)
              ],
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Tooltip(
              richMessage: TextSpan(
                children: [
                  TextSpan(
                      text:
                          "created: ${profile.createdTime.toIso8601String()}\n"),
                  TextSpan(
                      text:
                          "expire: ${profile.expirationTime?.toIso8601String()}\n"),
                  TextSpan(text: "up: ${profile.uploadTraffic.toString()}\n"),
                  TextSpan(
                      text: "down: ${profile.downloadTraffic.toString()}\n"),
                  TextSpan(text: "total: ${profile.totalTraffic.toString()}\n"),
                  TextSpan(text: "path: ${profile.path}"),
                ],
              ),
              child: Container(
                decoration: profile.path == profiles.currentProfilePath
                    ? BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [BoxShadow(blurRadius: 0)],
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                      )
                    : BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(blurRadius: 2, offset: Offset(2, 2))
                        ],
                        color: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                child: ListTile(
                    trailing: IconButton(
                      iconSize: 18,
                      icon: const Icon(Icons.delete_rounded),
                      onPressed: () => ref
                          .read(profilesProvider.notifier)
                          .deleteProfile(profile),
                    ),
                    onTap: profile.path == profiles.currentProfilePath
                        ? null
                        : () => ref
                            .read(profilesProvider.notifier)
                            .switchProfile(profile),
                    title: Row(
                      children: [
                        Text(
                          profile.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        if (profile.path == profiles.currentProfilePath)
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green),
                          ),
                      ],
                    ),
                    subtitle: Text(
                      profile.path,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium,
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
