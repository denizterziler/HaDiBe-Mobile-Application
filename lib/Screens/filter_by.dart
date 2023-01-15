import 'package:flutter/material.dart';

class FilterBy extends StatefulWidget {
  const FilterBy({Key? key}) : super(key: key);

  @override
  State<FilterBy> createState() => _FilterByState();
}

class _FilterByState extends State<FilterBy> {
  bool isCheckedSeries = false;
  bool isCheckedMovies = false;
  bool isCheckedNetflix = false;
  bool isCheckedDisney = false;
  bool isCheckedAction = false;
  bool isCheckedDram = false;
  bool isCheckedScifi = false;
  bool isCheckedComedy = false;
  bool isCheckedHorror = false;
  bool isCheckedAnimation = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
                                  });
                                },
                              ),
                              Text("Movies"),
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
                              value: isCheckedNetflix,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedNetflix = value!;
                                });
                              },
                            ),
                            Text("Netflix"),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Colors.amber,
                              value: isCheckedDisney,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedDisney = value!;
                                });
                              },
                            ),
                            Text("Disney+"),
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
                                  value: isCheckedAction,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedAction = value!;
                                    });
                                  },
                                ),
                                Text("Action"),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.amber,
                                  value: isCheckedScifi,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedScifi = value!;
                                    });
                                  },
                                ),
                                Text("Sci-fi"),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.amber,
                                  value: isCheckedHorror,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedHorror = value!;
                                    });
                                  },
                                ),
                                Text("Horror"),
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
                                  value: isCheckedDram,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedDram = value!;
                                    });
                                  },
                                ),
                                Text("Dram"),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.amber,
                                  value: isCheckedComedy,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedComedy = value!;
                                    });
                                  },
                                ),
                                Text("Comedy"),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.amber,
                                  value: isCheckedAnimation,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isCheckedAnimation = value!;
                                    });
                                  },
                                ),
                                Text("Animation"),
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
                          onPressed: null,
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
                              isCheckedNetflix = false;
                              isCheckedDisney = false;
                              isCheckedAction = false;
                              isCheckedDram = false;
                              isCheckedScifi = false;
                              isCheckedComedy = false;
                              isCheckedHorror = false;
                              isCheckedAnimation = false;
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
