// ignore_for_file: use_build_context_synchronously

import 'dart:io';
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
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/controllers/menu_controller.dart' as item;

class EditProductForm extends StatefulWidget {
  EditProductForm({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.productCategory,
    required this.isOnSale,
    required this.isPiece,
    required this.salePrice,
  });

  final String id, title, price, imageUrl, productCategory, salePrice;
  final bool isOnSale, isPiece;
  //final double salePrice;
  @override
  State<EditProductForm> createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController, _priceController;
  late String _categoryDropdown = 'Vegetables';
  String? _salePercentage;
  late String percentage;
  late String _salePrice;
  late bool _isOnsale;
  int _groupValue = 1;
  bool isPiece = true;
  File? _pickedImage;
  Uint8List? _pickedFromWeb;
  late String _imageUrl;
  late int val;
  late bool _isPiece;
  bool _isLoading = false;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.title);
    _priceController = TextEditingController(text: widget.price);
    //set the variables
    _salePrice = widget.salePrice;
    _categoryDropdown = widget.productCategory;
    _isOnsale = widget.isOnSale;
    _isPiece = widget.isPiece;
    val = _isPiece ? 2 : 1;
    _imageUrl = widget.imageUrl;
    //calculate percentage
    percentage =
        (100 - (double.parse(_salePrice) * 100) / double.parse(widget.price))
            .round()
            .toStringAsFixed(1);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    super.dispose();
  }

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

      try {
        setState(() {
          _isLoading = true;
        });
        if (_pickedImage != null) {
          final ref = FirebaseStorage.instance
              .ref()
              .child('productImage')
              .child('${widget.id}.jpg');
          if (kIsWeb) {
            await ref.putData(_pickedFromWeb!);
          } else {
            await ref.putFile(_pickedImage!);
          }
          imageUrl = await ref.getDownloadURL();
        }

        await FirebaseFirestore.instance
            .collection("products")
            .doc(widget.id)
            .update({
          'id': widget.id,
          'title': _titleController.text,
          'productCategory': _categoryDropdown,
          'price': _priceController.text,
          'salePrice': _salePrice,
          'imageUrl': imageUrl == null ? widget.imageUrl : _imageUrl,
          'isPiece': isPiece,
          'isOnSale': _isOnsale,
          'createdAt': Timestamp.now(),
        });

        await Fluttertoast.showToast(
            msg: "Product has been Updated Successfully",
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
      //key: context.read<item.MenuController>().getEditProductScaffoldKey, //commented to come back to main page after deletion
      drawer: const SideMenu(),
      body: LoadingManager(
        isLoading: _isLoading && _isFormErrorFree,
        child: Row(
          children: [
            // if (Responsive.isDesktop(context)) //commented to come back to main page after deletion
            //   const Expanded(
            //     child: SideMenu(),
            //   ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Header(   //commented to come back to main page after deletion
                    //   fcn: () {
                    //     context
                    //         .read<item.MenuController>()
                    //         .controlEditProductsMenu();
                    //   },
                    //   title: 'Edit this Product',
                    //   showTextField: false,
                    // ),
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
                                              groupValue: val,
                                              onChanged: (valuee) {
                                                setState(() {
                                                  val = 1;
                                                  isPiece = false;
                                                });
                                              },
                                            ),
                                            TextWidget(
                                                text: 'Piece', color: color),
                                            Radio(
                                              activeColor: Colors.green,
                                              value: 2,
                                              groupValue: val,
                                              onChanged: (valuee) {
                                                setState(() {
                                                  val = 2;
                                                  isPiece = true;
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: _isOnsale,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  _isOnsale = newValue!;
                                                });
                                              },
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            TextWidget(
                                              text: "Sale",
                                              color: color,
                                              isTitle: true,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        AnimatedSwitcher(
                                          duration: const Duration(seconds: 1),
                                          child: !_isOnsale
                                              ? Container()
                                              : Row(
                                                  children: [
                                                    TextWidget(
                                                        text:
                                                            //"Rs ${_salePrice.toStringAsFixed(2)}",
                                                            "Rs $_salePrice",
                                                        color: color),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    _salePercentageDropDown(),
                                                  ],
                                                ),
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
                                          ? Image.network(_imageUrl)
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
                                // Expanded(
                                //   flex: 1,
                                //   child: FittedBox(
                                //       child: Column(
                                //     children: [
                                //       TextButton(
                                //         onPressed: () {
                                //           setState(() {
                                //             _pickedImage = null;
                                //             _pickedFromWeb = Uint8List(8);
                                //           });
                                //         },
                                //         child: TextWidget(
                                //           text: 'Clear',
                                //           color: Colors.red,
                                //         ),
                                //       ),
                                //       TextButton(
                                //         onPressed: () {},
                                //         child: TextWidget(
                                //           text: 'Upload image',
                                //           color: Colors.blue,
                                //         ),
                                //       ),
                                //     ],
                                //   )),
                                // )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ButtonWidget(
                                    onPressed: () async {
                                      GlobalMethods.warningDialogue(
                                          title: 'Delete?',
                                          subtitle: 'Press ok to confirm',
                                          fcn: () async {
                                            await FirebaseFirestore.instance
                                                .collection('products')
                                                .doc(widget.id)
                                                .delete();
                                            await Fluttertoast.showToast(
                                                msg:
                                                    "Product has been deleted Successfully",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.blue,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            while (Navigator.canPop(context)) {
                                              Navigator.pop(context);
                                            }
                                          },
                                          context: context);
                                    },
                                    text: 'Delete',
                                    icon: IconlyBold.danger,
                                    backgroundColor: Colors.redAccent,
                                  ),
                                  ButtonWidget(
                                    onPressed: () {
                                      _uploadForm();
                                    },
                                    text: 'Update',
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
          style: TextStyle(
              color: color, fontWeight: FontWeight.w200, fontSize: 20),
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

  Widget _salePercentageDropDown() {
    Color color = Utilities(context).color;
    //final _scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    return DropdownButtonHideUnderline(
        child: DropdownButton<String>(
      style: TextStyle(color: color, fontWeight: FontWeight.w400),
      hint: Text(_salePercentage ?? percentage),
      value: _salePercentage,
      onChanged: (value) {
        if (value == '0') {
          return;
        } else {
          setState(() {
            _salePercentage = value;
            _salePrice = (double.parse(widget.price) -
                    (double.parse(value!) * double.parse(widget.price) / 100))
                .toStringAsFixed(2);
          });
        }
      },
      items: const [
        DropdownMenuItem<String>(
          value: '10',
          child: Text(
            '10',
          ),
        ),
        DropdownMenuItem<String>(
          value: '15',
          child: Text(
            '15',
          ),
        ),
        DropdownMenuItem<String>(
          value: '25',
          child: Text(
            '25',
          ),
        ),
        DropdownMenuItem<String>(
          value: '50',
          child: Text(
            '50',
          ),
        ),
        DropdownMenuItem<String>(
          value: '75',
          child: Text(
            '75',
          ),
        ),
        DropdownMenuItem<String>(
          value: '0',
          child: Text(
            '0',
          ),
        ),
      ],
    ));
  }
}
