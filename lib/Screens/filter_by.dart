import 'package:flutter/material.dart';

class FilterBy extends StatefulWidget {
  const FilterBy({Key? key}) : super(key: key);

  @override
  State<FilterBy> createState() => _FilterByState();
}

class _FilterByState extends State<FilterBy> {
  bool isCheckedSeries = false;
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
                            children: const [
                              Checkbox(
                                value: false,
                                onChanged: null,
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
                          children: const [
                            Checkbox(
                              value: false,
                              onChanged: null,
                            ),
                            Text("Netflix"),
                          ],
                        ),
                        Row(
                          children: const [
                            Checkbox(
                              value: false,
                              onChanged: null,
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
                              children: const [
                                Checkbox(
                                  value: false,
                                  onChanged: null,
                                ),
                                Text("Action"),
                              ],
                            ),
                            Row(
                              children: const [
                                Checkbox(
                                  value: false,
                                  onChanged: null,
                                ),
                                Text("Sci-fi"),
                              ],
                            ),
                            Row(
                              children: const [
                                Checkbox(
                                  value: false,
                                  onChanged: null,
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
                              children: const [
                                Checkbox(
                                  value: false,
                                  onChanged: null,
                                ),
                                Text("Dram"),
                              ],
                            ),
                            Row(
                              children: const [
                                Checkbox(
                                  value: false,
                                  onChanged: null,
                                ),
                                Text("Comedy"),
                              ],
                            ),
                            Row(
                              children: const [
                                Checkbox(
                                  value: false,
                                  onChanged: null,
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
                          onPressed: null,
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
