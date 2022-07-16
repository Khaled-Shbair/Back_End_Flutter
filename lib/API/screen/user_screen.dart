import 'package:data_base/API/models/api_response.dart';
import 'package:data_base/API/models/user.dart';
import 'package:flutter/material.dart';

import '../api/controllers/auth_api_controller.dart';
import '../api/controllers/user_api_controller.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'User',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                ApiResponse apiResponse = await AuthApiController().logout();
                if (apiResponse.status) {
                  Navigator.pushReplacementNamed(context, '/LoginApiScreen');
                }
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              )),
        ],
      ),
      body: FutureBuilder<List<User>>(
          future: UserApiController().readUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsetsDirectional.zero,
                    leading: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(snapshot.data![index].image),
                    ),
                    title: Text(snapshot.data![index].firstName),
                    subtitle: Text(snapshot.data![index].email),
                  );
                },
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.warning, size: 80),
                  Text(
                    'No data',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 24,
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}
