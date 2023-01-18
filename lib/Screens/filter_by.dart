import 'package:flutter/material.dart';

class FilterBy extends StatefulWidget {
  const FilterBy({Key? key}) : super(key: key);

  @override
  State<FilterBy> createState() => _FilterByState();
}

class _FilterByState extends State<FilterBy> {
  bool Series = false;
  bool Movies = false;
  bool Netflix = false;
  bool Disney = false;
  bool Action = false;
  bool Dram = false;
  bool Sci_fi = false;
  bool Comedy = false;
  bool Horror = false;
  bool Animation = false;
  Map<String, dynamic> filterData = {
    "Series": false,
    "Movies": false,
    "Netflix": false,
    "Disney": false,
    "Action": false,
    "Dram": false,
    "Sci_fi": false,
    "Comedy": false,
    "Horror": false,
    "Animation": false
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.75),
        centerTitle: true,
        title: const Text("Filter"),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context,filterData);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
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
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.amber,
                                value: Series,
                                onChanged: (bool? value) {
                                  setState(() {
                                    Series = value!;
                                    filterData["Series"] =
                                        Series;
                                  });
                                },
                              ),
                              const Text("Series"),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.amber,
                                value: Movies,
                                onChanged: (bool? value) {
                                  setState(() {
                                    Movies = value!;
                                    filterData["Movies"] =
                                        Movies;
                                  });
                                },
                              ),
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
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Colors.amber,
                              value: Netflix,
                              onChanged: (bool? value) {
                                setState(() {
                                  Netflix = value!;
                                  filterData["Netflix"] = Netflix;
                                });
                              },
                            ),
                            const Text("Netflix"),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Colors.amber,
                              value: Disney,
                              onChanged: (bool? value) {
                                setState(() {
                                  Disney = value!;
                                  filterData["Disney"] = Disney;
                                });
                              },
                            ),
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
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.amber,
                                  value: Action,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      Action = value!;
                                      filterData["Action"] = Action;
                                    });
                                  },
                                ),
                                const Text("Action"),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.amber,
                                  value: Sci_fi,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      Sci_fi = value!;
                                      filterData["Sci_fi"] = Sci_fi;
                                    });
                                  },
                                ),
                                const Text("Sci-fi"),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.amber,
                                  value: Horror,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      Horror = value!;
                                      filterData["Horror"] = Horror;
                                    });
                                  },
                                ),
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
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.amber,
                                  value: Dram,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      Dram = value!;
                                      filterData["Dram"] = Dram;
                                    });
                                  },
                                ),
                                const Text("Dram"),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.amber,
                                  value: Comedy,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      Comedy = value!;
                                      filterData["Comedy"] = Comedy;
                                    });
                                  },
                                ),
                                const Text("Comedy"),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.amber,
                                  value: Animation,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      Animation = value!;
                                      filterData["Animation"] = Animation;
                                    });
                                  },
                                ),
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
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.amber)),
                          icon: const Icon(Icons.save),
                          onPressed: () {
                            print(filterData.keys.where((element) => filterData[element] == true));
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
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.amber)),
                          icon: const Icon(Icons.lock_reset),
                          onPressed: () {
                            setState(() {
                              Series = false;
                              Movies = false;
                              Netflix = false;
                              Disney = false;
                              Action = false;
                              Dram = false;
                              Sci_fi = false;
                              Comedy = false;
                              Horror = false;
                              Animation = false;
                              filterData = {
                                "Series": false,
                                "Movies": false,
                                "Netflix": false,
                                "Disney": false,
                                "Action": false,
                                "Dram": false,
                                "Sci_fi": false,
                                "Comedy": false,
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
      ),
    );
  }
}
