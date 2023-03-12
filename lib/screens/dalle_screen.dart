import 'package:ai_magic/services/api/api_dalle.dart';
import 'package:ai_magic/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/dalle_widgets.dart';

class DalleScreen extends StatefulWidget {
  const DalleScreen({super.key});

  @override
  State<DalleScreen> createState() => _DalleScreenState();
}

class _DalleScreenState extends State<DalleScreen> {
  TextEditingController searchController = TextEditingController();
  var dropDownSize = ['small', 'medium', 'large'];
  var dropDownValue = ["256x256", "512x512", "1024x1024"];
  String? dropDownInitValue;
  String image = '';
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('PixelGenie'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 30, 8, 8),
                child: Row(
                  children: [
                    DalleTextFormField(searchController: searchController),
                    const SizedBox(width: 10),
                    dropDownMenu(),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: botBackgroundColor,
                      shape: const StadiumBorder()),
                  child: const Text("Generate"),
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: backgroundColor,
                        content: Text('AI Magic started....'),
                        duration: Duration(seconds: 5),
                      ),
                    );
                    if (searchController.text.isNotEmpty) {
                      image = await generateImage(
                        searchController.text,
                        dropDownInitValue!,
                      );

                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please Enter Something...'),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: botBackgroundColor,
                  borderRadius: BorderRadius.circular(20)),
              child: isLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SpinKitSpinningLines(
                          color: Colors.white,
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Turn you Imagination into Reality... 🪄",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        )
                      ],
                    )
                  : Image.network(image,
                      loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Colors.grey,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "Wait, while we're doing Magic 🪄",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            )
                          ],
                        ),
                      );
                    }),
            ),
          ),
        ],
      ),
    );
  }

/*------DropDownMenu--------*/
  Container dropDownMenu() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0),
      decoration: BoxDecoration(
          color: botBackgroundColor, borderRadius: BorderRadius.circular(20)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            hint: const Text('Select Size'),
            dropdownColor: botBackgroundColor,
            value: dropDownInitValue,
            items: List.generate(
              dropDownSize.length,
              (index) => DropdownMenuItem(
                value: dropDownValue[index],
                child: Text(dropDownSize[index]),
              ),
            ),
            onChanged: (newValue) {
              setState(() {
                dropDownInitValue = newValue;
              });
            }),
      ),
    );
  }
}
