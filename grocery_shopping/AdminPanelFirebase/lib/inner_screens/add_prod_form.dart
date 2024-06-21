import 'dart:io';
import 'dart:math';

import 'package:admin_panel/responsive.dart';
import 'package:admin_panel/screens/loading_manager.dart';
import 'package:admin_panel/services/global_methods.dart';
import 'package:admin_panel/services/utilities.dart';
import 'package:admin_panel/widgets/buttons.dart';
import 'package:admin_panel/widgets/header.dart';
import 'package:admin_panel/widgets/side_menu.dart';
import 'package:admin_panel/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/controllers/menu_controller.dart' as item;
import 'package:uuid/uuid.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController, _priceController;
  String _categoryDropdown = 'Vegetables';
  int _groupValue = 1;
  bool isPiece = true;
  File? _pickedImage;
  Uint8List? _pickedFromWeb;

  @override
  void initState() {
    _titleController = TextEditingController();
    _priceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  bool _isFormErrorFree = false;

  void _uploadForm() async {
    final isValid = _formKey.currentState!.validate();
    _isFormErrorFree = isValid;
    FocusScope.of(context).unfocus();
    String? imageUrl;
    // setState(() {
    //   _isLoading = true;
    // });
    if (isValid) {
      _formKey.currentState!.save;
      if (_pickedImage == null) {
        GlobalMethods.errorDialogue(
            subtitle: 'Please select a image to upload', context: context);
        return;
      }
      final _uuid = const Uuid().v4();
      try {
        setState(() {
          _isLoading = true;
        });

        final ref = FirebaseStorage.instance
            .ref()
            .child('productImage')
            .child('$_uuid.jpg');
        if (kIsWeb) {
          await ref.putData(_pickedFromWeb!);
        } else {
          await ref.putFile(_pickedImage!);
        }
        imageUrl = await ref.getDownloadURL();
        await FirebaseFirestore.instance.collection("products").doc(_uuid).set({
          'id': _uuid,
          'title': _titleController.text,
          'productCategory': _categoryDropdown,
          'price': _priceController.text,
          'salePrice': 0.1,
          'imageUrl': imageUrl,
          'isPiece': isPiece,
          'isOnSale': false,
          'createdAt': Timestamp.now(),
        });
        _clearForm();
        Fluttertoast.showToast(
            msg: "Product Uploaded Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialogue(
            subtitle: '${error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        // ignore: use_build_context_synchronously
        GlobalMethods.errorDialogue(subtitle: '$error', context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _clearForm() {
    _titleController.clear();
    _priceController.clear();
    isPiece = false;
    _groupValue = 1;
    _categoryDropdown = 'Vegetables';
    setState(() {
      _pickedImage = null;
      _pickedFromWeb = Uint8List(8);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Utilities(context).getTheme;
    final color = Utilities(context).color;
    final _scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    Size size = Utilities(context).getScreenSize;

    var inputDecoration = InputDecoration(
      filled: true,
      fillColor: _scaffoldColor,
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1.0,
        ),
      ),
    );

    return Scaffold(
      key: context.read<item.MenuController>().getAddProductScaffoldKey,
      drawer: const SideMenu(),
      body: LoadingManager(
        isLoading: _isLoading && _isFormErrorFree,
        child: Row(
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(child: SideMenu()),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Header(
                      fcn: () {
                        context
                            .read<item.MenuController>()
                            .controlAddProductsMenu();
                      },
                      title: 'Add Products',
                      showTextField: false,
                    ),
                    Container(
                      width: size.width > 650 ? 650 : size.width,
                      color: Colors.amberAccent.shade100,
                      //color: Theme.of(context).cardColor,
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextWidget(
                              text: 'Product title',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _titleController,
                              key: const ValueKey('Title'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a title';
                                }
                                return null;
                              },
                              decoration: inputDecoration,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: FittedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextWidget(
                                          text: 'Price in Rupees',
                                          color: color,
                                          isTitle: true,
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: _priceController,
                                            key: const ValueKey('Rupees'),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter a title';
                                              }
                                              return null;
                                            },
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9.]')),
                                            ],
                                            decoration: inputDecoration,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextWidget(
                                          text: 'Product Category',
                                          color: color,
                                          isTitle: true,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        //drop down list
                                        _categoryDropdownProduct(),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextWidget(
                                          text: 'Measuing Unit',
                                          color: color,
                                          isTitle: true,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        //Radio Button
                                        Row(
                                          children: [
                                            TextWidget(
                                                text: 'KG', color: color),
                                            Radio(
                                              activeColor: Colors.green,
                                              value: 1,
                                              groupValue: _groupValue,
                                              onChanged: (valuee) {
                                                setState(() {
                                                  _groupValue = 1;
                                                  isPiece = false;
                                                });
                                              },
                                            ),
                                            TextWidget(
                                                text: 'Piece', color: color),
                                            Radio(
                                              activeColor: Colors.green,
                                              value: 2,
                                              groupValue: _groupValue,
                                              onChanged: (valuee) {
                                                setState(() {
                                                  _groupValue = 2;
                                                  isPiece = true;
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                //Image to be picked is here

                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: size.width > 650
                                        ? 350
                                        : size.width * 0.45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: _pickedImage == null
                                          ? _dottedBorder(color: color)
                                          : kIsWeb
                                              ? Image.memory(
                                                  _pickedFromWeb!,
                                                  fit: BoxFit.fill,
                                                )
                                              : Image.file(_pickedImage!,
                                                  fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                      child: Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _pickedImage = null;
                                            _pickedFromWeb = Uint8List(8);
                                          });
                                        },
                                        child: TextWidget(
                                          text: 'Clear',
                                          color: Colors.red,
                                        ),
                                      ),
                                      // TextButton(
                                      //   onPressed: () {},
                                      //   child: TextWidget(
                                      //     text: 'Upload image',
                                      //     color: Colors.blue,
                                      //   ),
                                      // ),
                                    ],
                                  )),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ButtonWidget(
                                    onPressed: () {
                                      _clearForm();
                                    },
                                    text: 'Clear Form',
                                    icon: Icons.dangerous,
                                    backgroundColor: Colors.redAccent,
                                  ),
                                  ButtonWidget(
                                    onPressed: () {
                                      _uploadForm();
                                    },
                                    text: 'Upload',
                                    icon: Icons.upload,
                                    backgroundColor: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //image picking code

  Future<void> _pickImageToUpload() async {
    //KIsweb is defalut function to check if the platform is web
    if (!kIsWeb) {
      final ImagePicker _pickImage = new ImagePicker();
      XFile? imageToUploadPath =
          await _pickImage.pickImage(source: ImageSource.gallery);
      if (imageToUploadPath != null) {
        //File() - relative path to current working directory path (or) absolute path - no changes
        var selectedMobileImage = File(imageToUploadPath.path);
        setState(() {
          _pickedImage = selectedMobileImage;
        });
      } else {
        print('No image has been picked to upload');
      }
    } else if (kIsWeb) {
      final ImagePicker _pickImage = new ImagePicker();
      XFile? imageToUploadPath =
          await _pickImage.pickImage(source: ImageSource.gallery);
      if (imageToUploadPath != null) {
        var selectedWebImage = await imageToUploadPath.readAsBytes();
        setState(() {
          _pickedFromWeb = selectedWebImage;
          //this below line to avoid error
          _pickedImage = File('a');
        });
      } else {
        print('No image has been picked to upload');
      }
    } else {
      print('Something went wrong!!!');
    }
  }

  Widget _dottedBorder({required Color color}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DottedBorder(
        dashPattern: const [6.7],
        borderType: BorderType.RRect,
        color: color,
        radius: const Radius.circular(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.image_outlined,
                size: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  _pickImageToUpload();
                },
                child: TextWidget(
                  text: 'Choose an Image',
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryDropdownProduct() {
    Color color = Utilities(context).color;
    final _scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    return Container(
      color: _scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
          style: TextStyle(color: color, fontWeight: FontWeight.w400),
          value: _categoryDropdown,
          onChanged: (value) {
            setState(() {
              _categoryDropdown = value!;
            });
          },
          items: const [
            DropdownMenuItem(
              value: 'Vegetables',
              child: Text(
                'Vegetables',
              ),
            ),
            DropdownMenuItem(
              value: 'Fruits',
              child: Text(
                'Fruits',
              ),
            ),
            DropdownMenuItem(
              value: 'Rice',
              child: Text(
                'Rice',
              ),
            ),
            DropdownMenuItem(
              value: 'Oil',
              child: Text(
                'Oil',
              ),
            ),
            DropdownMenuItem(
              value: 'Nuts',
              child: Text(
                'Nuts',
              ),
            ),
            DropdownMenuItem(
              value: 'Bread',
              child: Text(
                'Bread',
              ),
            ),
          ],
        )),
      ),
    );
  }
}
