import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se_380_project/Firebase/auth.dart';

class FilterBy extends StatefulWidget {
  const FilterBy({Key? key}) : super(key: key);

  @override
  State<FilterBy> createState() => _FilterByState();
}

class _FilterByState extends State<FilterBy> {
  final Auth _authService = Auth();

  bool Series = false;
  bool Movies = false;
  bool Netflix = false;
  bool Disney = false;
  bool Action = false;
  bool Dram = false;
  bool Sci_fi = false;
  bool Comics = false;
  bool Horror = false;
  bool Animation = false;
  bool isSaved = false;

  final firebaseUser = FirebaseAuth.instance.currentUser!;

  late var _streamData;
  Map<String, dynamic> filterData = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamData = FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser.uid)
        .snapshots();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.75),
        centerTitle: true,
        title: const Text("Filter"),
        leading: IconButton(
          onPressed: () {
            if(isSaved == true){
              Navigator.pop(context, filterData);
            }
              else{
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: StreamBuilder<Object>(
          stream: _streamData,
          builder: (context, snapshot) {
            return Container(
              color: Colors.black38,
              child: Center(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text(
                            "Type",
                            style: TextStyle(fontSize: 40),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0) +
                                const EdgeInsets.only(top: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    FutureBuilder(
                                        future: isTrue("Series"),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.data == true) {
                                            return IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  Series = snapshot.data!;
                                                  filterData["Series"] = Series;
                                                  _authService.FirebaseFiltersList("Series");
                                                });
                                              },
                                              icon: const Icon(Icons.check_box),
                                            );
                                          }
                                          if (snapshot.data == false) {
                                            return IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  Series = snapshot.data!;
                                                  filterData["Series"] = Series;
                                                  _authService.FirebaseFiltersList("Series");
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.check_box_outline_blank,
                                                color: Colors.black38,
                                              ),
                                            );
                                          }
                                          return const Text("Some error");
                                        }),
                                    const Text("Series"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    FutureBuilder(
                                        future: isTrue("Movies"),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.data == true) {
                                            return IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  Movies = snapshot.data!;
                                                  filterData["Movies"] = Movies;
                                                  _authService.FirebaseFiltersList("Movies");
                                                });
                                              },
                                              icon: const Icon(Icons.check_box),
                                            );
                                          }
                                          if (snapshot.data == false) {
                                            return IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  Movies = snapshot.data!;
                                                  filterData["Movies"] = Movies;
                                                  _authService.FirebaseFiltersList("Movies");
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.check_box_outline_blank,
                                                color: Colors.black38,
                                              ),
                                            );
                                          }
                                          return const Text("Some error");
                                        }),
                                    const Text("Movies"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const Text(
                          "Platform",
                          style: TextStyle(fontSize: 40),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0) +
                              const EdgeInsets.only(top: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  FutureBuilder(
                                      future: isTrue("Netflix"),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.data == true) {
                                          return IconButton(
                                            onPressed: () {
                                              setState(() {
                                                Netflix = snapshot.data!;
                                                filterData["Netflix"] = Netflix;
                                                _authService.FirebaseFiltersList("Netflix");
                                              });
                                            },
                                            icon: const Icon(Icons.check_box),
                                          );
                                        }
                                        if (snapshot.data == false) {
                                          return IconButton(
                                            onPressed: () {
                                              setState(() {
                                                Netflix = snapshot.data!;
                                                filterData["Netflix"] = Netflix;
                                                _authService.FirebaseFiltersList("Netflix");
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.check_box_outline_blank,
                                              color: Colors.black38,
                                            ),
                                          );
                                        }
                                        return const Text("Some error");
                                      }),
                                  const Text("Netflix"),
                                ],
                              ),
                              Row(
                                children: [
                                  FutureBuilder(
                                      future: isTrue("Disney"),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.data == true) {
                                          return IconButton(
                                            onPressed: () {
                                              setState(() {
                                                Disney = snapshot.data!;
                                                filterData["Disney"] = Disney;
                                                _authService.FirebaseFiltersList("Disney");
                                              });
                                            },
                                            icon: const Icon(Icons.check_box),
                                          );
                                        }
                                        if (snapshot.data == false) {
                                          return IconButton(
                                            onPressed: () {
                                              setState(() {
                                                Disney = snapshot.data!;
                                                filterData["Disney"] = Disney;
                                                _authService.FirebaseFiltersList("Disney");
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.check_box_outline_blank,
                                              color: Colors.black38,
                                            ),
                                          );
                                        }
                                        return const Text("Some error");
                                      }),
                                  const Text("Disney+"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Category",
                          style: TextStyle(fontSize: 40),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0) +
                              const EdgeInsets.only(top: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      FutureBuilder(
                                          future: isTrue("Action"),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.data == true) {
                                              return IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    Action = snapshot.data!;
                                                    filterData["Action"] = Action;
                                                    _authService.FirebaseFiltersList("Action");
                                                  });
                                                },
                                                icon: const Icon(Icons.check_box),
                                              );
                                            }
                                            if (snapshot.data == false) {
                                              return IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    Action = snapshot.data!;
                                                    filterData["Action"] = Action;
                                                    _authService.FirebaseFiltersList("Action");
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.check_box_outline_blank,
                                                  color: Colors.black38,
                                                ),
                                              );
                                            }
                                            return const Text("Some error");
                                          }),
                                      const Text("Action"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FutureBuilder(
                                          future: isTrue("Sci_fi"),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.data == true) {
                                              return IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    Sci_fi = snapshot.data!;
                                                    filterData["Sci_fi"] = Sci_fi;
                                                    _authService.FirebaseFiltersList("Sci_fi");
                                                  });
                                                },
                                                icon: const Icon(Icons.check_box),
                                              );
                                            }
                                            if (snapshot.data == false) {
                                              return IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    Sci_fi = snapshot.data!;
                                                    filterData["Sci_fi"] = Sci_fi;
                                                    _authService.FirebaseFiltersList("Sci_fi");
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.check_box_outline_blank,
                                                  color: Colors.black38,
                                                ),
                                              );
                                            }
                                            return const Text("Some error");
                                          }),
                                      const Text("Sci-fi"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FutureBuilder(
                                          future: isTrue("Horror"),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.data == true) {
                                              return IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    Horror = snapshot.data!;
                                                    filterData["Horror"] = Horror;
                                                    _authService.FirebaseFiltersList("Horror");
                                                  });
                                                },
                                                icon: const Icon(Icons.check_box),
                                              );
                                            }
                                            if (snapshot.data == false) {
                                              return IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    Horror = snapshot.data!;
                                                    filterData["Horror"] = Horror;
                                                    _authService.FirebaseFiltersList("Horror");
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.check_box_outline_blank,
                                                  color: Colors.black38,
                                                ),
                                              );
                                            }
                                            return const Text("Some error");
                                          }),
                                      const Text("Horror"),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      FutureBuilder(
                                          future: isTrue("Dram"),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.data == true) {
                                              return IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    Dram = snapshot.data!;
                                                    filterData["Dram"] = Dram;
                                                    _authService.FirebaseFiltersList("Dram");
                                                  });
                                                },
                                                icon: const Icon(Icons.check_box),
                                              );
                                            }
                                            if (snapshot.data == false) {
                                              return IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    Dram = snapshot.data!;
                                                    filterData["Dram"] = Dram;
                                                    _authService.FirebaseFiltersList("Dram");
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.check_box_outline_blank,
                                                  color: Colors.black38,
                                                ),
                                              );
                                            }
                                            return const Text("Some error");
                                          }),
                                      const Text("Dram"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FutureBuilder(
                                          future: isTrue("Comics"),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.data == true) {
                                              return IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    Comics = snapshot.data!;
                                                    filterData["Comics"] = Comics;
                                                    _authService.FirebaseFiltersList("Comics");
                                                  });
                                                },
                                                icon: const Icon(Icons.check_box),
                                              );
                                            }
                                            if (snapshot.data == false) {
                                              return IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    Comics = snapshot.data!;
                                                    filterData["Comics"] = Comics;
                                                    _authService.FirebaseFiltersList("Comics");
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.check_box_outline_blank,
                                                  color: Colors.black38,
                                                ),
                                              );
                                            }
                                            return const Text("Some error");
                                          }),
                                      const Text("Comics"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FutureBuilder(
                                          future: isTrue("Animation"),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.data == true) {
                                              return IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    Animation = snapshot.data!;
                                                    filterData["Animation"] = Animation;
                                                    _authService.FirebaseFiltersList("Animation");
                                                  });
                                                },
                                                icon: const Icon(Icons.check_box),
                                              );
                                            }
                                            if (snapshot.data == false) {
                                              return IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    Animation = snapshot.data!;
                                                    filterData["Animation"] = Animation;
                                                    _authService.FirebaseFiltersList("Animation");
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.check_box_outline_blank,
                                                  color: Colors.black38,
                                                ),
                                              );
                                            }
                                            return const Text("Some error");
                                          }),
                                      const Text("Animation"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Column(
                            children: [
                              ElevatedButton.icon(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.amber)),
                                icon: const Icon(Icons.save),
                                onPressed: () {
                                  print(filterData.keys.where((element) =>
                                      filterData[element] == true));
                                  _authService.addToFirebaseFilters(
                                      filterData.keys.where((element) =>
                                          filterData[element] == true));
                                  isSaved = true;
                                  _saved(context);
                                },
                                label: const Text("Save"),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Column(
                            children: [
                              ElevatedButton.icon(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.amber)),
                                icon: const Icon(Icons.lock_reset),
                                onPressed: () {
                                  setState(() {
                                    _authService.resetFilters();
                                    _reset(context);
                                    filterData = {
                                      "Series": false,
                                      "Movies": false,
                                      "Netflix": false,
                                      "Disney": false,
                                      "Action": false,
                                      "Dram": false,
                                      "Sci_fi": false,
                                      "Comics": false,
                                      "Horror": false,
                                      "Animation": false
                                    };
                                  });
                                },
                                label: const Text("Reset"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
  void _saved(BuildContext context) {
    const snackBar = SnackBar(
        content: Text("Your filters has been saved")
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void _reset(BuildContext context) {
    const snackBar = SnackBar(
        content: Text("Your filters has been reset")
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  isTrue(String filterName) async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Users').doc(firebaseUser.uid);
    DocumentSnapshot doc = await documentReference.get();
    List filters = doc['filters'];
    if (filters.contains(filterName) == true) {
      return true;
    } else {
      return false;
    }
  }
}
