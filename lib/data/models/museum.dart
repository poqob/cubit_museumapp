class Museum {
  late final String name;
  late final String text;
  late final String img;
  Museum(this.name, this.text, this.img);

  Museum.fromList(List museum) {
    name = museum[0];
    text = museum[1];
    img = museum[2];
  }

  //after flutter integration may fromPathToNetworkImage method~getter has developed.
}
