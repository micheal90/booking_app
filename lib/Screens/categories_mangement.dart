import 'package:booking_app/constants.dart';
import 'package:booking_app/providers/main_provider.dart';
import 'package:booking_app/widgets_model/custom_elevated_button.dart';
import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:booking_app/widgets_model/main_drawer.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesManagementScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKeyUpdate = GlobalKey();
  final GlobalKey<FormState> _formKeyAdd = GlobalKey();
  final TextEditingController nameAddController = TextEditingController();
  final TextEditingController imageUrlAddController = TextEditingController();

  void update(BuildContext context, MainProvider value) async {
    FocusScope.of(context).unfocus();

    if (!_formKeyUpdate.currentState!.validate()) return;
    _formKeyUpdate.currentState!.save();
    await value.updateCategory().then((value) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Category updated')));
    });
  }

  void add(BuildContext context, MainProvider value) async {
    FocusScope.of(context).unfocus();
    if (!_formKeyAdd.currentState!.validate()) return;
    _formKeyAdd.currentState!.save();
    // await value
    //     .addCtegory(nameAddController.text, imageUrlAddController.text)
    //     .then((value) {
    //   Navigator.of(context).pop();
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text('Category added')));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
          child: Scaffold(
        appBar: AppBar(
          //centerTitle: true,
          title: Text('Categories Management'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<MainProvider>(
            builder: (context, value, child) => ListView.separated(
                itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          NetworkImage(value.categories[index].imageUrl,),
                    ),
                    title: CustomText(
                      text: value.categories[index].name,
                    ),
                    subtitle: CustomText(
                      text: '',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: CustomText(
                                    text: 'Edit Category',
                                  ),
                                  content: Form(
                                    key: _formKeyUpdate,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            initialValue:
                                                value.categories[index].name,
                                            decoration: InputDecoration(
                                                labelText: 'Category Name'),
                                            onSaved: (String? val) {
                                              value.categories[index].name = val!;
                                            },
                                            validator: (String? val) {
                                              if (val!.isEmpty) {
                                                return 'Enter name';
                                              } else
                                                return null;
                                            },
                                          ),
                                          TextFormField(
                                            initialValue:
                                                value.categories[index].imageUrl,
                                            decoration: InputDecoration(
                                                labelText: 'Image Url'),
                                            onSaved: (String? val) {
                                              value.categories[index].imageUrl =
                                                  val!;
                                            },
                                            validator: (String? val) {
                                              if (val!.isEmpty) {
                                                return 'Enter image Url';
                                              } else
                                                return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          OutlinedButton(
                                              onPressed: () =>
                                                  update(context, value),
                                              child: CustomText(
                                                text: 'Update',
                                                alignment: Alignment.center,
                                                color: KPrimaryColor,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: KPrimaryColor,
                            )),
                            
                        // IconButton(
                        //     onPressed: () {
                        //       showDialog(
                        //         context: context,
                        //         builder: (context) => AlertDialog(
                        //           title: CustomText(
                        //             text: 'Are you sure',
                        //           ),
                        //           content: Column(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: [
                        //               CustomText(
                        //                 text: ' category delete',
                        //               ),
                        //               SizedBox(
                        //                 height: 20,
                        //               ),
                        //               Row(
                        //                 mainAxisAlignment: MainAxisAlignment.end,
                        //                 children: [
                        //                   TextButton(
                        //                       onPressed: () =>
                        //                           Navigator.of(context).pop(),
                        //                       child: Text('No')),
                        //                   TextButton(
                        //                       onPressed: () async {
                        //                         await value
                        //                             .deleteCategory()
                        //                             .then((value) {
                        //                           Navigator.of(context).pop();
                        //                           ScaffoldMessenger.of(context)
                        //                               .showSnackBar(SnackBar(
                        //                                   content: Text(
                        //                                       'The category has been deleted')));
                        //                         });
                        //                       },
                        //                       child: Text('Yes')),
                        //                 ],
                        //               )
                        //             ],
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //     icon: Icon(
                        //       Icons.delete,
                        //       color: Colors.red,
                        //     )),
                      ],
                    )),
                separatorBuilder: (context, index) => Divider(),
                itemCount: value.categories.length),
          ),
        ),
        //floatingActionButton: buildFloatingActionButton(),
        drawer: MainDrawer(),
      ),
    );
  }

  Consumer<MainProvider> buildFloatingActionButton() {
    return Consumer<MainProvider>(
      builder: (context, value, child) => FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: CustomText(
                text: 'Add Category',
              ),
              content: Form(
                key: _formKeyAdd,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameAddController,
                        decoration: InputDecoration(labelText: 'Category Name'),
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return 'Enter name';
                          } else
                            return null;
                        },
                      ),
                      TextFormField(
                        controller: imageUrlAddController,
                        decoration: InputDecoration(labelText: 'Image Url'),
                        validator: (String? val) {
                          if (val!.isEmpty ||
                              (!val.startsWith('http') &&
                              !val.startsWith('https') )||
                              (!val.endsWith('png') &&
                              !val.endsWith('jpg'))) {
                            return 'Enter a valid image url\nwith end of (.png) or (.jpg) like this:\nhttps://linkOfIcon.png';
                          } else
                            return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomElevatedButton(
                        text: 'Add',
                        onPressed: () => add(context, value),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
