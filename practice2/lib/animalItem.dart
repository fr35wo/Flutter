class Animal{
  String? imagePath;
  String? animalName;
  String? kind;
  bool? flyExist = false;

  Animal(
  {
    required this.animalName,
    required this.imagePath,
    required this.kind,
    this.flyExist
}
      );
}