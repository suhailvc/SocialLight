import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var sizeQuery = MediaQuery.of(context).size;
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 226, 231, 231),
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: sizeQuery.height * 0.03,
          ),
          SizedBox(
            height: sizeQuery.height * 0.07,
            width: sizeQuery.height * 0.45,
            child: TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 4),
                isDense: true,
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Color.fromARGB(255, 230, 230, 230),
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 226, 231, 231),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: sizeQuery.height * 0.01),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                indent: 80,
                thickness: 1.9,
              ),
              physics: const BouncingScrollPhysics(),
              //shrinkWrap: true,
              itemCount: 50,
              itemBuilder: (context, index) {
                return ListTile(
                    leading: CircleAvatar(
                      //backgroundImage: AssetImage('assets/images/download (1).jpeg',),
                      radius: 23,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/download (1).jpeg',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: const Text(
                      'Suhaill',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    subtitle: const Text('user name'),
                    trailing: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.teal, // Customize the button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Customize the border radius
                        ),
                      ),
                      child: const Text(
                        'Follow', // Customize the text
                        style: TextStyle(
                          color: Colors.white, // Customize the text color
                          fontWeight:
                              FontWeight.bold, // Customize the text style
                        ),
                      ),
                    ));
              },
            ),
          )
        ],
      )),
    );
  }
}
