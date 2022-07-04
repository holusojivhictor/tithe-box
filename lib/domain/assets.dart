class Assets {
  static String imageBasePath = 'assets/images';
  static String svgsBasePath = 'assets/svgs';

  static String getImagePath(String name) => '$imageBasePath/$name';
  static String getSvgPath(String name) => '$svgsBasePath/$name';
}