import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentro/details_screen.dart';
import 'package:zentro/product_bloc.dart';
import 'package:zentro/product_management.dart';
import 'package:zentro/product_state.dart';
import 'package:zentro/service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = "";
  int currentBannerIndex = 0;

  final List<String> bannerImages = [
    'assets/header3.png',
    'assets/header2.png',
    'assets/header.png',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductBloc(ProductRepository())..add(FetchProducts()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Color.fromARGB(255, 54, 81, 69),
                Color.fromARGB(255, 112, 128, 122)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: const Text(
              "ZENTRO",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.shopping_cart_outlined, color: Colors.black),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search products...",
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                ),
              ),
              SizedBox(
                height: 180,
                child: Stack(
                  children: [
                    PageView.builder(
                      itemCount: bannerImages.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentBannerIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return bannerImage(bannerImages[index]);
                      },
                    ),
                    Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          bannerImages.length,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: currentBannerIndex == index ? 12 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: currentBannerIndex == index
                                  ? const Color.fromARGB(179, 91, 88, 88)
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shop By Category",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 110,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    categoryItem("Women",
                        "https://www.andindia.com/dw/image/v2/BGCX_PRD/on/demandware.static/-/Sites-masterCatalog_ANDIndia/default/dwa753dec4/images/hires/SS22/S25V275DRPYD_blue_prt%20(2)%20copy.jpg?sw=400&sh=600&sm=fit&strip=false"),
                    const SizedBox(
                      width: 10,
                    ),
                    categoryItem("Men",
                        "https://surhi.in/cdn/shop/collections/Mens_Wear.webp?v=1721029303"),
                    const SizedBox(
                      width: 10,
                    ),
                    categoryItem("Teens",
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZY9P-oikrNp3PePZCqQLnDywJlmz1jSPu_g&s"),
                    const SizedBox(
                      width: 10,
                    ),
                    categoryItem("Kids",
                        "https://peekaabookids.com/cdn/shop/files/0Z4A4373.png?v=1739291633&width=533"),
                    const SizedBox(
                      width: 10,
                    ),
                    categoryItem("Baby",
                        "https://cdn.shopify.com/s/files/1/0004/0245/6582/files/baby_mobile_hero.jpg"),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Suggested for You",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductLoaded) {
                    final filteredProducts = state.products.where((product) {
                      return product.title.toLowerCase().contains(searchQuery);
                    }).toList();

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) =>
                                      DetailScreen(product: product),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 6,
                              color: Colors.grey[100],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        product.image,
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      product.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.green, size: 14),
                                        Text(
                                          " ${product.rating.rate}(${product.rating.count})",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[800]),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "₹${product.price.toStringAsFixed(0)}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is ProductError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bannerImage(String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imagePath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget categoryItem(String name, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 35,
          ),
          const SizedBox(height: 4),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
