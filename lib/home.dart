// digGit imports 📝
import 'package:diggit/components/fab.dart';
import 'package:diggit/components/repos.dart';
import 'package:diggit/models/reposModel.dart';
import 'package:diggit/models/meetsModel.dart';

// pub.dev & flutter imports ✅
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:basics/basics.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Meets meets = Provider.of<Meets>(context);
    ReposNotifier repos = Provider.of<ReposNotifier>(context);
    if (meets.isNotNull) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                overflow: Overflow.visible,
                children: [
                  Container(
                    color: Color.fromRGBO(30, 33, 37, 1),
                    height: 370,
                  ),
                  Positioned(
                    top: 330,
                    height: 150,
                    child: Container(
                      padding: EdgeInsets.all(14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bio',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            // width: MediaQuery.of(context).size.width - 60,
                            child: AutoSizeText(
                              meets.bio ??
                                  "This person doesn't seem to have much to say about themselves 📢",
                              maxLines: 5,
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87),
                            ),
                          )
                        ],
                      ),
                      width: 340,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[800],
                              blurRadius: 30,
                            )
                          ],
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  Positioned(
                    left: 42,
                    top: 85,
                    child: Container(
                      height: 85,
                      width: 85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: NetworkImage(meets.avatarUrl)),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 25,
                              spreadRadius: 10)
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    bottom: 140,
                    child: Text(
                      'Hi I am,',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 30),
                    ),
                  ),
                  Positioned(
                      left: 40,
                      bottom: 65,
                      child: Container(
                        width: 300,
                        height: 80,
                        child: AutoSizeText(
                          meets.name ?? 'No Name',
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.w800),
                        ),
                      ))
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 150, left: 45),
                child: Text(
                  'People',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, left: 25, right: 25),
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              meets.followers.toString() ?? 'Oops',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            Text('Followers',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                          ]),
                    ),
                    VerticalDivider(
                      indent: 8,
                      endIndent: 8,
                      width: 2,
                      color: Colors.grey[300],
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              meets.following.toString() ?? 'Oops',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            Text('Following',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                          ]),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey[500], blurRadius: 20)
                    ],
                    borderRadius: BorderRadius.circular(12)),
              ),
              Container(
                margin: EdgeInsets.only(top: 35, left: 45),
                child: Text(
                  'Repositories',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              repos.repos.isNotNull
                  ? Container(
                      height: 200,
                      margin: EdgeInsets.only(right: 10),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: repos.repos.length,
                          itemBuilder: (context, index) => RepoList(
                                repos: repos.repos[index],
                              )),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 20, bottom: 30),
                      child: Center(
                        child: Text(
                          "This person doesn't seem to make a lot of repos 🤷‍♂️",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      ),
                    )
            ],
          ),
          floatingActionButton: FAB(launchUrl: () async {
            String url = meets.htmlUrl;
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              print("Couldn't launch the person's GitHub profile");
            }
          }));
    } else {
      return Scaffold(
        body: Center(
            child: Text(
          'Finding you a new Meet...',
          style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w700),
        )),
      );
    }
  }
}
