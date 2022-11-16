import 'package:flutter/material.dart';
import 'package:login_page/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color.fromARGB(253, 21, 151, 86),
        actions: [
          IconButton(
              onPressed: () {
                signout(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
          child: ListView.separated(
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text('Person ${index + 1}'),
                  subtitle: Text('${index + 2} min ago'),
                  leading: (index % 2 == 0)
                      ? const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage('assets/images/avatar.jpg'),
                        )
                      : ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 44,
                            minHeight: 44,
                            maxWidth: 64,
                            maxHeight: 64,
                          ),
                          child: Image.asset('assets/images/userSquare.jpeg'),
                        ),
                  // trailing: Text('${index + 2} min ago'),
                  trailing: Column(
                    children: [
                      Text(
                        '${index + 1}:00 PM',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.green),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: CircleAvatar(
                          radius: 13,
                          backgroundColor:
                              const Color.fromARGB(255, 2, 241, 10),
                          child: Text(
                            '${20 - index}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount: 20)),
    );
  }
}

signout(BuildContext ctx) async {
  final sharedPrefs = await SharedPreferences.getInstance();
  await sharedPrefs.clear();
  // ignore: use_build_context_synchronously
  Navigator.of(ctx).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx1) => const ScreenLogin()),
      (route) => false);
}
