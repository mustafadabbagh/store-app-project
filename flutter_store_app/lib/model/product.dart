class Products {
  String clubShirt;
  String shirtDetails;
  String club;
  double shirtPrice;
  Products({
    required this.clubShirt,
    required this.shirtPrice,
    required this.shirtDetails,
    required this.club,
  });
}

List item = [
  Products(club:"Barcelona", clubShirt: "assets/barca_shirt.jpg", shirtPrice: 29.99,shirtDetails:"The Nike FC Barcelona 2023-2024 home jersey returns to the club's most classic shirt design that was introduced in 1912 and used more or less in the same style until the 1990s. The Nike FC Barcelona 23-24 home jersey features two wide red stripes on the front. The sleeves are red."),
  Products(club:"Real Madrid",clubShirt: "assets/madrid_shirt.jpg", shirtPrice: 29.99,shirtDetails:"For the first time in the club's history, the Real Madrid 23-24 home kit features the club's slogan ¡Hala Madrid! on the collar. For the collar, Adidas combine the goldish-orange, White & Legend Ink into a Tricolor. The sleeve cuffs also come with the Tricolor."),
  Products(club:"Manchister City", clubShirt: "assets/mancity_shirt.jpg", shirtPrice: 29.99,shirtDetails: "The Puma Manchester City 2023-24 home shirt is mainly Team Light Blue, the same color as last season. Complementing the traditional sky blue is white, used for the logos and on the collar detailing."),
  Products(club:"PSG", clubShirt: "assets/psg_shirt.jpg", shirtPrice: 29.99,shirtDetails: "The Nike PSG 2023-24 home shirt is navy with a red stripe on the left that fades toward the bottom of the shirt. There is also a fading white stripe on the left and right of the red stripe, inspired by the team's classic Hechter design."),
  Products(club:"Arsenal", clubShirt: "assets/arsenal_shirt.jpg", shirtPrice: 25.99,shirtDetails: "In contrast to the shirt of the 2005-2006 season, the Adidas Arsenal FC 2023-24 home jersey has white sleeves and a more traditional red color. This makes it more traditional for the club and very different from the kit from almost 20 years ago."),
];
