import 'package:flutter/material.dart';
import 'package:finalexam202301_seokhyeon_201914068/util/contact_sqlite_database_provider.dart';
import 'model/contact.dart';

class MaterialMain extends StatefulWidget {
  final ContactSQLiteDatabaseProvider databaseProvider;
  const MaterialMain({required this.databaseProvider});

  @override
  State<MaterialMain> createState() => _MaterialMain();
}

class _MaterialMain extends State<MaterialMain> {
  Future<List<Contact>>? contactList;

  @override
  void initState() {
    super.initState();
    contactList = _getContacts();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Final Exam App 2023-01'),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: contactList,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if(snapshot.connectionState == ConnectionState.done) {
                if(snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  return ListView.separated(itemCount: (snapshot.data as List<Contact>).length,
                  separatorBuilder: (context,index) {
                    return const Divider(
                      height: 1,
                      color: Colors.blueGrey,
                    );
                  },
                    itemBuilder: (context,index) {
                     Contact contact = (snapshot.data as List<Contact>)[index];
                     return ListTile(
                       title: Text(contact.name! , style: TextStyle(fontSize: 14),),
                       subtitle: Column(
                         children: <Widget>[
                           Text(contact.address!),
                           Text(contact.phoneNumber!),
                         ],
                       ),
                       onTap: () {
                         _updateContact(contact);
                       },
                       onLongPress: () {
                         _deleteContact(contact);
                       },
                     );
                    },
                  );
                } else {
                  return Text("Empty Data");
                }
              } else {
                return Text("connectionState: ${snapshot.connectionState}");
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create),
        onPressed: () {
          _createContact();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _createContact() async {
    Contact contact = await Navigator.of(context).pushNamed('/create') as Contact;
    await widget.databaseProvider.insertContact(contact);
    setState(() {
      contactList = _getContacts();
    });
  }

  Future<List<Contact>> _getContacts() async{
    return widget.databaseProvider.getContacts();
  }

  Future<void> _updateContact(Contact contact) async {
    TextEditingController tecAddressController = TextEditingController(text: contact.address);
    TextEditingController tecPhoneNumberController = TextEditingController(text: contact.phoneNumber);
    var resContact = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("${contact.id}: ${contact.name}"),
            content: StatefulBuilder(
              builder: (context, setDialogState) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: tecAddressController,
                        decoration: InputDecoration(labelText: "주소",),
                      ),
                      TextField(
                        controller: tecPhoneNumberController,
                        decoration: InputDecoration(labelText: "전화번호",),
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              ElevatedButton(
                  child: Text("수정"),
                  onPressed: () {
                    contact.address = tecAddressController.value.text;
                    contact.phoneNumber = tecPhoneNumberController.value.text;
                    Navigator.of(context).pop(contact);
                  },
              ),
              ElevatedButton(
                  child: Text("취소"),
                onPressed: () {
                  Navigator.of(context).pop(contact);
                },
              )
            ],
          );
        }
    );
    if(resContact != null){
      await widget.databaseProvider.updateContact(resContact);
      setState(() {
        contactList = _getContacts();
      });
    }
  }

  Future<void> _deleteContact(Contact contact) async {
    var result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("${contact.id}: ${contact.name}"),
            content: Text("연락처를 삭제하시겠습니까?"),
            actions: <Widget>[
              ElevatedButton(
                  child: Text("삭제"),
                onPressed: () {
                    Navigator.of(context).pop(true);
                },
              ),
              ElevatedButton(
                child: Text("취소"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          );
        }
    );

    if(result as bool) {
      await widget.databaseProvider.deleteContact(contact);
      setState(() {
        contactList = _getContacts();
      });
    }

  }

}