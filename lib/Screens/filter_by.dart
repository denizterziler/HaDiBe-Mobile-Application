import 'package:flutter/material.dart';

class FilterBy extends StatefulWidget {
  const FilterBy({Key? key}) : super(key: key);

  @override
  State<FilterBy> createState() => _FilterByState();
}

class _FilterByState extends State<FilterBy> {
  bool isCheckedSeries = false;
  bool isCheckedMovies = false;
  bool netflix = false;
  bool disney = false;
  bool action = false;
  bool dram = false;
  bool sci_fi = false;
  bool comedy = false;
  bool horror = false;
  bool animation = false;
  Map<String, dynamic> filterData = {
    "isCheckedSeries": false,
    "isCheckedMovies": false,
    "netflix": false,
    "disney": false,
    "action": false,
    "dram": false,
    "sci_fi": false,
    "comedy": false,
    "horror": false,
    "animation": false
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.75),
        centerTitle: true,
        title: const Text("Filter"),
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
                                value: isCheckedSeries,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isCheckedSeries = value!;
                                    filterData["isCheckedSeries"] =
                                        isCheckedSeries;
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
                                value: isCheckedMovies,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isCheckedMovies = value!;
                                    filterData["isCheckedMovies"] =
                                        isCheckedMovies;
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
                              value: netflix,
                              onChanged: (bool? value) {
                                setState(() {
                                  netflix = value!;
                                  filterData["netflix"] = netflix;
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
                              value: disney,
                              onChanged: (bool? value) {
                                setState(() {
                                  disney = value!;
                                  filterData["disney"] = disney;
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
                                  value: action,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      action = value!;
                                      filterData["action"] = action;
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
                                  value: sci_fi,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      sci_fi = value!;
                                      filterData["sci_fi"] = sci_fi;
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
                                  value: horror,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      horror = value!;
                                      filterData["horror"] = horror;
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
                                  value: dram,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      dram = value!;
                                      filterData["dram"] = dram;
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
                                  value: comedy,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      comedy = value!;
                                      filterData["comedy"] = comedy;
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
                                  value: animation,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      animation = value!;
                                      filterData["animation"] = animation;
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
                            print(filterData);
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
                              isCheckedSeries = false;
                              isCheckedMovies = false;
                              netflix = false;
                              disney = false;
                              action = false;
                              dram = false;
                              sci_fi = false;
                              comedy = false;
                              horror = false;
                              animation = false;
                              filterData = {
                                "isCheckedSeries": false,
                                "isCheckedMovies": false,
                                "netflix": false,
                                "disney": false,
                                "action": false,
                                "dram": false,
                                "sci_fi": false,
                                "comedy": false,
                                "horror": false,
                                "animation": false
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
