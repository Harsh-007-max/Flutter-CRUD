import 'package:flutter/material.dart';
import 'package:flutter_crud/api_executor.dart';
import 'package:flutter_crud/widgets/custom_button.dart';
import './widgets/customInput.dart';

const List<String> list = <String>["Male", "Female"];

class AddEditPage extends StatelessWidget {
  const AddEditPage({super.key, this.edit});
  final dynamic edit;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("${edit == null ? "Add" : "Edit"} New Person"),
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          body: CustomForm(edit: edit)),
    );
  }
}

class CustomForm extends StatefulWidget {
  const CustomForm({super.key, this.edit});
  final dynamic edit;
  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  dynamic _genderController = "Male";

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() => _nameController.text));
    _descriptionController
        .addListener(() => setState(() => _descriptionController.text));
    if (widget.edit != null) {
      _nameController.text = widget.edit[ApiExecutor.NAME];
      _descriptionController.text = widget.edit[ApiExecutor.DESCRIPTION];
      _genderController = widget.edit[ApiExecutor.GENDER];
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(7),
              child: CustomInput(
                leadIcon: Icons.person,
                controller: _nameController,
                name: "Enter Name",
              ),
            ),
            Container(
              margin: const EdgeInsets.all(7),
              child: CustomInput(
                  controller: _descriptionController,
                  name: "Enter Description"),
            ),
            Container(
              margin: const EdgeInsets.all(7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 40),
                    child: const Text("Gender:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        )),
                  ),
                  DropdownButton(
                    icon: const Icon(Icons.arrow_drop_down),
                    underline: Container(height: 2, color: Colors.deepPurple),
                    onChanged: (newValue) {
                      setState(() => _genderController = newValue!);
                    },
                    value: _genderController,
                    items: list.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
            CustomElevatedButton(
              childWidget: Text("${widget.edit == null ? "Add" : "Edit"} User"),
              onPressedFunc: () {
                if (_formKey.currentState!.validate()) {
                  dynamic body = {
                    ApiExecutor.NAME: _nameController.text.toString(),
                    ApiExecutor.DESCRIPTION:
                        _descriptionController.text.toString(),
                    ApiExecutor.GENDER: _genderController.toString(),
                  };
                  _addEditPersonApiCall(body, widget.edit);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void _addEditPersonApiCall(body, data) async {
    if (data != null) {
      await ApiExecutor()
          .updateByPersonID(widget.edit[ApiExecutor.PERSONID], body);
    } else {
      await ApiExecutor().addNewPerson(body);
    }
    if (mounted) {
      Navigator.pop(context);
    }
  }
}
