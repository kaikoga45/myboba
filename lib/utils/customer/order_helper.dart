class OrderHelper {
  static String createDescription(
      {required String size,
      required String iceAmount,
      required String sugarAmount,
      required int grassJelly,
      required int redBean,
      required int rainbowJelly,
      required int mousse,
      required int pearl,
      required int aloeVera}) {
    String description;
    int toppingAdded =
        grassJelly + redBean + rainbowJelly + mousse + pearl + aloeVera;

    if (toppingAdded != 0) {
      String grassJellyText =
          grassJelly.toString() != '0' ? '$grassJelly grass jelly, ' : '';
      String redBeanText =
          redBean.toString() != '0' ? '$redBean red bean, ' : '';
      String rainbowJellyText =
          rainbowJelly.toString() != '0' ? '$rainbowJelly rainbow jelly, ' : '';
      String mousseText = mousse.toString() != '0' ? '$mousse mousse, ' : '';
      String pearlText = pearl.toString() != '0' ? '$pearl pearl, ' : '';
      String aloeVeraText =
          aloeVera.toString() != '0' ? '$aloeVera aloe vera, ' : '';

      description = size +
          ' with amount ' +
          sugarAmount.toLowerCase() +
          ' sugar and ' +
          iceAmount.toLowerCase() +
          ' ice. Extra topping ' +
          grassJellyText +
          redBeanText +
          rainbowJellyText +
          mousseText +
          pearlText +
          aloeVeraText;
    } else {
      description = size +
          ' with amount ' +
          sugarAmount.toLowerCase() +
          ' sugar and ' +
          iceAmount.toLowerCase() +
          ' ice. No Topping';
    }
    return description;
  }

  static int calculateTotalPrice(
      {required int menu,
      required int size,
      required int ice,
      required int sugar,
      required int topping}) {
    int total = menu + size + ice + sugar + topping;
    return total;
  }
}
