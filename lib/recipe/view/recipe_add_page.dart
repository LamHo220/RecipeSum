import 'dart:io';

import 'package:animations/animations.dart';
import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:recipe_box/app/app.dart';
import 'package:recipe_box/common/constants/colors.dart';
import 'package:recipe_box/common/constants/paddings.dart';
import 'package:recipe_box/common/constants/style.dart';
import 'package:recipe_box/explore/view/explore_page.dart';
import 'package:recipe_box/home/cubit/home_cubit.dart';
import 'package:recipe_box/recipe/bloc/recipe_bloc.dart';
import 'package:recipe_repository/recipe_repository.dart';

class RecipeAddView extends StatelessWidget {
  const RecipeAddView({
    Key? key,
    required this.action,
  }) : super(key: key);

  final RAction action;

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc value) => value.state.user);
    final userDetails =
        context.select((HomeCubit value) => value.state.userDetails);

    final flag = context.select((HomeCubit value) => value.state.flag);
    final recipeBloc = BlocProvider.of<RecipeBloc>(context);

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Add Recipe'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: ThemeColors.text,
        ),
        body: SafeArea(
          bottom: true,
          child: SingleChildScrollView(
            child: Column(children: [
              InkWell(
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();
                    final XFile? file =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (file != null) {
                      recipeBloc.add(PickingImage(file));
                      final ImageCropper _cropper = ImageCropper();
                      // final CroppedFile? croppedFile =
                      //     await _cropper.cropImage(sourcePath: file.path);
                      // if (croppedFile != null) {
                      //   recipeBloc.add(CroppingImage(croppedFile));
                      // }
                    }
                  },
                  child: BlocBuilder<RecipeBloc, RecipeState>(
                    builder: (context, state) => Container(
                      alignment: Alignment.bottomLeft,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                          color: ThemeColors.card,
                          image: DecorationImage(
                              image: state.file != null
                                  ? FileImage(File(state.file.path))
                                  : Image.asset('assets/camera.png').image)),
                      child: Container(
                        color: ThemeColors.halfGray,
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, top: 8, bottom: 8),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.account_circle,
                              color: ThemeColors.white,
                            ),
                            Pad.w8,
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              direction: Axis.vertical,
                              children: [
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.ideographic,
                                  children: [
                                    Text(
                                      user.username ?? user.email ?? '',
                                      style: Style.cardTitle,
                                    ),
                                    Pad.w4,
                                    Text(
                                      'lv${userDetails.level}',
                                      style: Style.cardSubTitle
                                          .copyWith(fontSize: 12),
                                    )
                                  ],
                                ),
                                Text(
                                  "${0} recipes shared",
                                  style: Style.cardSubTitle,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
              Container(
                padding: EdgeInsetsDirectional.only(start: 12, end: 12),
                child: Column(
                  children: [
                    Container(
                      padding: Pad.pa12,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            children: [
                              Expanded(child: _NameInput()),
                              Pad.w8,
                              Expanded(
                                flex: 2,
                                child: Row(children: [
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: Colors.red[600],
                                        size: 16,
                                      ),
                                      Text('0')
                                    ],
                                  ),
                                  Pad.w8,
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: const [
                                      Icon(
                                        FontAwesomeIcons.codeFork,
                                        color: ThemeColors.gray,
                                        size: 16,
                                      ),
                                      Text('0')
                                    ],
                                  )
                                ]),
                              )
                            ],
                          ),
                          Pad.h8,
                          Container(
                            padding: Pad.pa12,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(12),
                                border: Border.all(
                                  color: ThemeColors.inactive,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    // TODO
                                    _CalInput(),
                                    Text(
                                      'cal',
                                      style: Style.label.copyWith(fontSize: 12),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    _GramInput(),
                                    Text(
                                      'gram',
                                      style: Style.label.copyWith(fontSize: 12),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '0',
                                      style: Style.highlightText,
                                    ),
                                    Text(
                                      'rating',
                                      style: Style.label.copyWith(fontSize: 12),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    _TimeInput(),
                                    Text(
                                      'is needed',
                                      style: Style.label.copyWith(fontSize: 12),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      recipeBloc.state.steps.length.toString(),
                                      style: Style.highlightText,
                                    ),
                                    Text(
                                      'steps',
                                      style: Style.label.copyWith(fontSize: 12),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Pad.h12,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            children: [
                              const Text(
                                'Ingredients',
                                style: Style.heading,
                              ),
                              Text('${recipeBloc.state.ingredients.length} items',
                                  style: Style.label
                                      .copyWith(color: ThemeColors.inactive))
                            ],
                          ),
                          Pad.h24,
                          _IngredientInput(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    context.read<RecipeBloc>().addIngredient();
                                  },
                                  icon: Icon(Icons.add_circle_outline_outlined))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            children: [
                              const Text(
                                'Steps',
                                style: Style.heading,
                              ),
                              Text('${recipeBloc.state.ingredients.length} steps',
                                  style: Style.label
                                      .copyWith(color: ThemeColors.inactive))
                            ],
                          ),
                          Pad.h24,
                          _StepInput(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    context.read<RecipeBloc>().addSteps();
                                  },
                                  icon: Icon(Icons.add_circle_outline_outlined))
                            ],
                          ),
                          _CategoriesChoice(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            children: const [
                              Text(
                                'Description',
                                style: Style.heading,
                              ),
                            ],
                          ),
                          _DescriptionInput(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            children: const [
                              Text(
                                'Notes from you',
                                style: Style.heading,
                              ),
                            ],
                          ),
                          _NoteInput(),
                          Pad.h24,
                          Row(
                            children: [
                              Text(
                                'Is Public?',
                                style: Style.heading,
                              ),
                              _SetIsPublic()
                            ],
                          ),
                          Pad.h24,
                          ElevatedButton(
                            onPressed: () {
                              context.read<RecipeBloc>().submit(user, action);
                              context.read<HomeCubit>().setFlag(!flag);
                              Navigator.pop(context);
                            },
                            child: Text('Post'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ThemeColors.primaryLight),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}

class RecipeAddPage extends StatelessWidget {
  RecipeAddPage({super.key, this.recipe, required this.action});

  final Recipe? recipe;

  final RAction action;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => RecipeBloc(recipe: recipe),
        child: WillPopScope(
            child: RecipeAddView(
              action: action,
            ),
            onWillPop: () async {
              return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Do you really want to leave?'),
                      content: Text('Your draft will not be saved.'),
                      actions: [
                        TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: ThemeColors.primaryDark),
                          child: Text("Cancel"),
                          onPressed: () => Navigator.pop(context, false),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: ThemeColors.primaryDark),
                          child: Text("Confirm"),
                          onPressed: () => Navigator.pop(context, true),
                        )
                      ],
                    );
                  }).then((x) => x ?? false);
            }));
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFormField(
          key: const Key('name_input_textField'),
          // controller: TextEditingController(text: state.name.value),
          keyboardType: TextInputType.text,
          initialValue: state.name.value,
          onChanged: (value) => context.read<RecipeBloc>().nameChanged(value),
          style: Style.heading,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            border: UnderlineInputBorder(),
            labelText: 'name*',
            errorText: state.name.invalid ? 'required' : null,
          ),
        );
      },
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return TextFormField(
          key: const Key('description_input_textField'),
          // controller: TextEditingController(text: state.description.value),
          minLines: 2,
          maxLines: 100,
          keyboardType: TextInputType.text,
          initialValue: state.description.value,
          onChanged: (value) =>
              context.read<RecipeBloc>().descriptionChanged(value),
          decoration: const InputDecoration(
            labelText: 'description',
            contentPadding: EdgeInsets.all(0),
            border: UnderlineInputBorder(),
            alignLabelWithHint: true,
          ),
        );
      },
    );
  }
}

class _StepInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
        buildWhen: (previous, current) =>
            previous.steps.length != current.steps.length,
        builder: (context, state) => state.steps.isNotEmpty
            ? ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: state.steps.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(
                  color: ThemeColors.white,
                ),
                key: Key('steps'),
                itemBuilder: (context, index) => TextField(
                  controller: state.steps[index],
                  // onChanged: (value) =>
                  //     context.read<RecipeBloc>().stepChanged(index, value),
                  decoration: InputDecoration(
                      labelText: 'step ${(index + 1)}*',
                      errorText:
                          state.steps[index].text.isEmpty ? 'required' : null,
                      suffixIcon: IconButton(
                          onPressed: () =>
                              context.read<RecipeBloc>().deleteStep(index),
                          icon: Icon(Icons.close))),
                ),
              )
            : Container());
  }
}

class _IngredientInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
        buildWhen: (previous, current) =>
            previous.ingredients != current.ingredients,
        builder: (context, state) => state.ingredients.isNotEmpty
            ? ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: state.ingredients.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(
                  color: ThemeColors.white,
                ),
                key: Key('ingredients'),
                itemBuilder: (context, index) => Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: state.ingredients[index]['name'],
                        decoration: InputDecoration(
                          labelText: 'item ${(index + 1)}*',
                          helperText: 'required',
                          errorText:
                              state.ingredients[index]['name']!.text.isEmpty
                                  ? 'required'
                                  : null,
                        ),
                      ),
                    ),
                    Pad.w4,
                    Expanded(
                        child: TextField(
                      controller: state.ingredients[index]['value'],
                      decoration: InputDecoration(
                          labelText: 'serving size ${(index + 1)}*',
                          helperText: 'required',
                          errorText:
                              state.ingredients[index]['value']!.text.isEmpty
                                  ? 'required'
                                  : null,
                          suffixIcon: IconButton(
                              onPressed: () => context
                                  .read<RecipeBloc>()
                                  .deleteIngredient(index),
                              icon: Icon(Icons.close))),
                    ))
                  ],
                ),
              )
            : Container());
  }
}

class _CalInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      buildWhen: (previous, current) => previous.cal != current.cal,
      builder: (context, state) {
        return NumberPicker(
            minValue: 0,
            itemCount: 1,
            itemWidth: 48 * state.cal.toString().length.toDouble() / 3,
            selectedTextStyle: Style.highlightText,
            step: 50,
            textStyle: Style.label,
            itemHeight: 35,
            maxValue: 100000,
            value: state.cal,
            onChanged: (value) => context.read<RecipeBloc>().calChanged(value));
      },
    );
  }
}

class _GramInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      buildWhen: (previous, current) => previous.gram != current.gram,
      builder: (context, state) {
        return NumberPicker(
            minValue: 0,
            itemCount: 1,
            itemWidth: 48 * state.cal.toString().length.toDouble() / 3,
            selectedTextStyle: Style.highlightText,
            step: 50,
            textStyle: Style.label,
            itemHeight: 35,
            maxValue: 100000,
            value: state.gram,
            onChanged: (value) =>
                context.read<RecipeBloc>().gramChanged(value));
      },
    );
  }
}

class _TimeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hour = context.select((RecipeBloc value) => value.state.time)['hr'];

    final minute =
        context.select((RecipeBloc value) => value.state.time)['min'];

    void updateHour(int value) {
      context.read<RecipeBloc>().setHour(value);
    }

    void updateMinute(int value) {
      context.read<RecipeBloc>().setMinute(value);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        NumberPicker(
          value: hour!,
          minValue: 0,
          itemCount: 1,
          itemWidth: 48 * hour.toString().length.toDouble() / 3,
          selectedTextStyle: Style.highlightText,
          step: 1,
          textStyle: Style.label,
          itemHeight: 35,
          maxValue: 23,
          onChanged: (value) => updateHour(value),
        ),
        const Text(
          ' hr',
          style: Style.search,
        ),
        NumberPicker(
          value: minute!,
          minValue: 0,
          itemCount: 1,
          itemWidth: 48 * minute.toString().length.toDouble() / 3,
          selectedTextStyle: Style.highlightText,
          step: 1,
          textStyle: Style.label,
          itemHeight: 35,
          maxValue: 59,
          onChanged: (value) => updateMinute(value),
        ),
        const Text(
          ' min',
          style: Style.search,
        ),
      ],
    );
  }
}

class _NoteInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      buildWhen: (previous, current) => previous.note != current.note,
      builder: (context, state) {
        return TextFormField(
          key: const Key('note_input_textField'),
          // controller: TextEditingController(text: state.note),
          minLines: 1,
          maxLines: 100,
          initialValue: state.note,
          keyboardType: TextInputType.text,
          onChanged: (value) => context.read<RecipeBloc>().noteChanged(value),
          style: Style.heading,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            border: UnderlineInputBorder(),
            labelText: 'note',
          ),
        );
      },
    );
  }
}

class _SetIsPublic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
        buildWhen: (previous, current) => previous.isPublic != current.isPublic,
        builder: (context, state) {
          return Switch(
              value: state.isPublic,
              activeColor: ThemeColors.primaryLight,
              onChanged: (val) =>
                  context.read<RecipeBloc>().changeIsPublic(val));
        });
  }
}

class _CategoriesChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      buildWhen: (previous, current) =>
          previous.categories != current.categories,
      builder: (context, state) => SmartSelect.multiple(
          tileBuilder: (context, state2) {
            return S2Tile.fromState(
              state2,
              hideValue: true,
              body: S2TileChips(
                chipLength: state.categories.length,
                chipLabelBuilder: (context, i) {
                  return Text(state.categories[i].name);
                },
                // chipAvatarBuilder: (context, i) {
                //   return CircleAvatar(
                //     backgroundImage: NetworkImage(state.valueObject[i].meta['picture']['thumbnail'])
                //   );
                // },
                chipOnDelete: (i) =>
                    context.read<RecipeBloc>().removeCategory(i),
                chipColor: ThemeColors.primaryLight,
              ),
            );
          },
          onChange: (value) =>
              context.read<RecipeBloc>().onCategoriesChange(value),
          title: 'Categories',
          choiceActiveStyle: S2ChoiceStyle(
            color: ThemeColors.primaryLight,
          ),
          modalType: S2ModalType.popupDialog,
          choiceItems: Categories.values
              .map((e) => S2Choice(value: e, title: e.name))
              .toList()),
    );
  }
}
