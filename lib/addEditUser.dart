import 'package:flutter/material.dart';
import 'package:flutter_crud/api_crud_model.dart';
import 'package:flutter_crud/api_executor.dart';
import 'package:flutter_crud/widgets/custom_button.dart';
import './widgets/customInput.dart';

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
  final _nameController = new TextEditingController();
  final _descriptionController = new TextEditingController();
  final _genderController = true;
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() => _nameController.text));
    _descriptionController
        .addListener(() => setState(() => _descriptionController.text));
    if (widget.edit != null) {
      _nameController.text = widget.edit[ApiExecutor.NAME];
      _descriptionController.text = widget.edit[ApiExecutor.DESCRIPTION];
    }
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
              child:
                  CustomInput(controller: _nameController, name: "Enter Name"),
            ),
            Container(
              margin: const EdgeInsets.all(7),
              child: CustomInput(
                  controller: _descriptionController,
                  name: "Enter Description"),
            ),
            CustomElevatedButton(
              childWidget: Text("${widget.edit == null ? "Add" : "Edit"} User"),
              onPressedFunc: () {
                if (_formKey.currentState!.validate()) {
                  dynamic body = {
                    ApiExecutor.NAME: _nameController.text.toString(),
                    ApiExecutor.DESCRIPTION:
                        _descriptionController.text.toString(),
                    ApiExecutor.GENDER: "Male",
                  };
                  if (widget.edit != null) {
                    ApiExecutor()
                        .updateByPersonID(
                            widget.edit[ApiExecutor.PERSONID], body)
                        .then((res) => {Navigator.pop(context)});
                  } else {
                    ApiExecutor()
                        .addNewPerson(body)
                        .then((res) => {Navigator.pop(context)});
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
