import 'package:crestaurant2/app/widgets/card_resto_widget.dart';
import 'package:crestaurant2/app/widgets/error_widget.dart';
import 'package:crestaurant2/provider/search_restaurant_provider.dart';
import 'package:crestaurant2/values/Icons.dart';
import 'package:crestaurant2/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/restaurant_model.dart';
import '../detail/detail_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      appBar: appBarWidget(context),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Search(),
      ),
    );
  }

  PreferredSizeWidget appBarWidget(BuildContext context) {
    return AppBar(
      title: Text(
        AppLocalizations.of(context)!.findYourFavoriteFood,
        style: const TextStyle(color: dark),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: SvgPicture.asset(
          back,
          width: 30,
          color: dark,
        ),
      ),
    );
  }
}

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late bool _isShowClear = false;

  final TextEditingController _search = TextEditingController(text: "");

  final List<String> _popularSearch = [
    "Napolitana",
    "Kari kacang dan telur",
    "Salad yuzu",
    "Kafein",
    "Sosis squash dan mint",
    "Coklat panas",
    "Bring Your Phone Cafe",
  ];

  @override
  void initState() {
    super.initState();
    final searchProvider =
        Provider.of<SearchRestaurantProvider>(context, listen: false);
    searchProvider.setDefaultState();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void searchRestaurant() async {
    final searchProvider =
        Provider.of<SearchRestaurantProvider>(context, listen: false);
    if (_search.text.isNotEmpty) {
      setState(() {
        _isShowClear = true;
      });
      await searchProvider.searchRestaurant(value: _search.text);
    } else {
      searchProvider.setDefaultState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchRestaurantProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _search,
          cursorColor: primary,
          keyboardType: TextInputType.text,
          maxLines: 1,
          onChanged: (value) {
            setState(() {
              _isShowClear = value.isNotEmpty;
              searchRestaurant();
            });
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: grey2,
              prefixIcon: SizedBox(
                width: 10,
                height: 10,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(search, width: 10),
                ),
              ),
              suffixIcon: _isShowClear
                  ? InkWell(
                      onTap: () {
                        searchProvider.setDefaultState();
                        _search.clear();
                        setState(() {
                          _isShowClear = false;
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.cancel,
                          color: lipstickRed,
                        ),
                      ),
                    )
                  : null,
              hintText: "Bebek Penyet"),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Consumer<SearchRestaurantProvider>(
            builder: (context, SearchRestaurantProvider data, _) {
              switch (data.state) {
                case ResultState.loading:
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primary,
                    ),
                  );
                case ResultState.connectionError:
                  return noConnection();
                case ResultState.noData:
                  return notFound();
                case ResultState.hasData:
                  return ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        Restaurant data = searchProvider.searchResult[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(data: data),
                              ),
                            );
                          },
                          child: CardRestoWidget(
                            image: data.pictureId,
                            name: data.name,
                            city: data.city,
                            rating: data.rating,
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, _) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: searchProvider.searchResult.length);
                case ResultState.error:
                  return errorCode();
                default:
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.popularSearch,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  color: dark, fontWeight: FontWeight.bold),
                        ),
                        Wrap(
                          spacing: 2,
                          children: _popularSearch
                              .map(
                                (e) => ChoiceChip(
                                  label: Text(
                                    e,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(fontWeight: FontWeight.w400),
                                  ),
                                  selected: false,
                                  onSelected: (_) {
                                    setState(() {
                                      _search.text = e;
                                      searchProvider.setDefaultState();
                                      searchRestaurant();
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        )
                      ],
                    ),
                  );
              }
            },
          ),
        )
      ],
    );
  }
}
