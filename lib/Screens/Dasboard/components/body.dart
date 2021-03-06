import 'package:flutter/material.dart';
import 'package:project_uts/Screens/Dasboard/components/navbar.dart';
import 'package:project_uts/Screens/Dasboard/components/background.dart';
import 'package:project_uts/Screens/Profil/profil_screen.dart';
import 'package:project_uts/constants.dart';
import 'package:project_uts/json_list/user_model.dart';
import 'package:project_uts/json_list/user_view_model.dart';

// class BodyDashboard extends StatelessWidget {
//   const BodyDashboard({Key? key}) : super(key: key);

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     return const NavBar();
//   }
// }

class BodyPage extends StatefulWidget {
  const BodyPage({Key? key}) : super(key: key);

  @override
  _BodyPageState createState() => _BodyPageState();
}

class _BodyPageState extends State {
  List dataUser = [];
  void getDataUser() {
    UserViewModel().getUsers().then((value) {
      setState(() {
        dataUser = value;
      });
    });
  }

  Widget personDetailCard(UserModel data) {
    return CustomScrollView(
      shrinkWrap: true,
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.only(top: 10, right: 5, bottom: 10, left: 5),
          sliver: SliverGrid.count(
            crossAxisCount: 2,
            crossAxisSpacing: 50,
            mainAxisSpacing: 50,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                color: kPrimaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.nama,
                      style: const TextStyle(color: kPrimaryLightColor, fontSize: 18),
                    ),
                    Text(
                      data.nim,
                      style: const TextStyle(color: kPrimaryLightColor, fontSize: 12),
                    ),
                    Text(
                      data.prodi,
                      style: const TextStyle(color: kPrimaryLightColor, fontSize: 12),
                    ),
                    Text(
                      data.agama,
                      style: const TextStyle(color: kPrimaryLightColor, fontSize: 12),
                    )
                ]),
              )

            ],
          ),
          ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  showDetailDialog(UserModel data) {
    showDialog(
          context: context,
          builder: (context) {
          return SimpleDialog(
            title: const Text('Detail Person'),
            children: <Widget>[
              Text("Name : ${data.nama}"),
              Text("Name : ${data.nim}"),
              Text("Name : ${data.prodi}"),
              Text("Name : ${data.alamat}"),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          // title: const Text("Dashboard"),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Expanded(child: Text("Dashboard")),
              
            ],
          ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: GestureDetector(
                child: const Text(
                    "Profil",
                    style: TextStyle(fontSize: 20),textAlign: TextAlign.end,
                  ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ProfilScreen();
                  }));
                },
              ),
            ),
          ]),
      body: Background(
        child: Center(
          child: ListView.builder(
            itemBuilder: (context, i) {
            return personDetailCard(dataUser[i]);
          },
          itemCount: dataUser == null ? 0 : dataUser.length,),
        ),
      ));
  }
}
