import 'package:estionnaire/gestionnaire/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../provider/trie_class.dart';

class ProviderDemoScreen extends StatefulWidget {
  const ProviderDemoScreen({Key? key}) : super(key: key);

  @override
  _ProviderDemoScreenState createState() => _ProviderDemoScreenState();
}

class _ProviderDemoScreenState extends State<ProviderDemoScreen> {
  List palstique = [];
  @override
  void initState() {
    super.initState();
    final postModel = Provider.of<TrieClass>(context, listen: false);
    postModel.getPostData(
        Provider.of<LoginProvider>(context, listen: false).tokenuser);
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<TrieClass>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider Demo"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: postModel.loading
            ? Center(
                child: Container(
                  child: SpinKitThreeBounce(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: index.isEven ? Colors.red : Colors.green,
                        ),
                      );
                    },
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        List.generate(postModel.post!.triee.length, (index) {
                      palstique = postModel.post!.triee[index]['plastique'];
                      return SizedBox(
                        height: 400,
                        child: ListView(
                            children: List.generate(palstique.length, (i) {
                          return Text(palstique[i]["nom_poubelle_responsable"]);
                        })),
                      );
                    })),
              ),
      ),
    );
  }
}
