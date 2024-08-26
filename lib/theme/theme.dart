import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      primary: Colors.blue,
      surface: Colors.white,
      brightness: Brightness.light),
  appBarTheme: const AppBarTheme(
    color: Colors.blue,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white),
  hoverColor: Colors.lightBlueAccent,
  listTileTheme: const ListTileThemeData(
      tileColor: Colors.white,
      selectedTileColor: Colors.lightBlue,
      selectedColor: Colors.white),
);

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        primary: Colors.deepPurple,
        surface: const Color.fromARGB(255, 43, 41, 41),
        brightness: Brightness.dark),
    iconTheme: const IconThemeData(color: Colors.white),
    appBarTheme: const AppBarTheme(
      color: Colors.deepPurple,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black12),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    hoverColor: Colors.deepPurpleAccent,
    listTileTheme: const ListTileThemeData(
      tileColor: Color.fromARGB(255, 59, 53, 53),
      leadingAndTrailingTextStyle: TextStyle(color: Colors.white),
      iconColor: Colors.white,
      selectedTileColor: Colors.deepPurple,
      selectedColor: Colors.white,
    ),
    inputDecorationTheme: const InputDecorationTheme(
        fillColor: Color.fromARGB(255, 50, 47, 47),
        prefixIconColor: Colors.white),
    hintColor: Colors.white);

ThemeData accessibilityTheme = ThemeData();



/////////////////////////////////////////// colours below

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4284962190),
      surfaceTint: Color(4284962190),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4293582335),
      onPrimaryContainer: Color(4280422214),
      secondary: Color(4284636016),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4293517048),
      onSecondaryContainer: Color(4280162603),
      tertiary: Color(4286468703),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294957538),
      onTertiaryContainer: Color(4281405468),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      background: Color(4294899711),
      onBackground: Color(4280097568),
      surface: Color(4294899711),
      onSurface: Color(4280097568),
      surfaceVariant: Color(4293386475),
      onSurfaceVariant: Color(4282991950),
      outline: Color(4286215551),
      outlineVariant: Color(4291544271),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281478965),
      inverseOnSurface: Color(4294307831),
      inversePrimary: Color(4291935485),
      primaryFixed: Color(4293582335),
      onPrimaryFixed: Color(4280422214),
      primaryFixedDim: Color(4291935485),
      onPrimaryFixedVariant: Color(4283317621),
      secondaryFixed: Color(4293517048),
      onSecondaryFixed: Color(4280162603),
      secondaryFixedDim: Color(4291609307),
      onSecondaryFixedVariant: Color(4283056984),
      tertiaryFixed: Color(4294957538),
      onTertiaryFixed: Color(4281405468),
      tertiaryFixedDim: Color(4293966022),
      onTertiaryFixedVariant: Color(4284758855),
      surfaceDim: Color(4292794592),
      surfaceBright: Color(4294899711),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294504954),
      surfaceContainer: Color(4294110452),
      surfaceContainerHigh: Color(4293715694),
      surfaceContainerHighest: Color(4293386472),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4283054448),
      surfaceTint: Color(4284962190),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4286409638),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282794068),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4286148999),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4284430147),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4288112501),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      background: Color(4294899711),
      onBackground: Color(4280097568),
      surface: Color(4294899711),
      onSurface: Color(4280097568),
      surfaceVariant: Color(4293386475),
      onSurfaceVariant: Color(4282728778),
      outline: Color(4284636519),
      outlineVariant: Color(4286478723),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281478965),
      inverseOnSurface: Color(4294307831),
      inversePrimary: Color(4291935485),
      primaryFixed: Color(4286409638),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4284764812),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4286148999),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4284504174),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4288112501),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4286271324),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292794592),
      surfaceBright: Color(4294899711),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294504954),
      surfaceContainer: Color(4294110452),
      surfaceContainerHigh: Color(4293715694),
      surfaceContainerHighest: Color(4293386472),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4280883021),
      surfaceTint: Color(4284962190),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4283054448),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4280622898),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4282794068),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281931555),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4284430147),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      background: Color(4294899711),
      onBackground: Color(4280097568),
      surface: Color(4294899711),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4293386475),
      onSurfaceVariant: Color(4280689451),
      outline: Color(4282728778),
      outlineVariant: Color(4282728778),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281478965),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4294109439),
      primaryFixed: Color(4283054448),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4281541209),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4282794068),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4281346621),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4284430147),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4282786093),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292794592),
      surfaceBright: Color(4294899711),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294504954),
      surfaceContainer: Color(4294110452),
      surfaceContainerHigh: Color(4293715694),
      surfaceContainerHighest: Color(4293386472),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4291935485),
      surfaceTint: Color(4291935485),
      onPrimary: Color(4281804380),
      primaryContainer: Color(4283317621),
      onPrimaryContainer: Color(4293582335),
      secondary: Color(4291609307),
      onSecondary: Color(4281544001),
      secondaryContainer: Color(4283056984),
      onSecondaryContainer: Color(4293517048),
      tertiary: Color(4293966022),
      onTertiary: Color(4283049265),
      tertiaryContainer: Color(4284758855),
      onTertiaryContainer: Color(4294957538),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      background: Color(4279505432),
      onBackground: Color(4293386472),
      surface: Color(4279505432),
      onSurface: Color(4293386472),
      surfaceVariant: Color(4282991950),
      onSurfaceVariant: Color(4291544271),
      outline: Color(4287926169),
      outlineVariant: Color(4282991950),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293386472),
      inverseOnSurface: Color(4281478965),
      inversePrimary: Color(4284962190),
      primaryFixed: Color(4293582335),
      onPrimaryFixed: Color(4280422214),
      primaryFixedDim: Color(4291935485),
      onPrimaryFixedVariant: Color(4283317621),
      secondaryFixed: Color(4293517048),
      onSecondaryFixed: Color(4280162603),
      secondaryFixedDim: Color(4291609307),
      onSecondaryFixedVariant: Color(4283056984),
      tertiaryFixed: Color(4294957538),
      onTertiaryFixed: Color(4281405468),
      tertiaryFixedDim: Color(4293966022),
      onTertiaryFixedVariant: Color(4284758855),
      surfaceDim: Color(4279505432),
      surfaceBright: Color(4282071102),
      surfaceContainerLowest: Color(4279176467),
      surfaceContainerLow: Color(4280097568),
      surfaceContainer: Color(4280360740),
      surfaceContainerHigh: Color(4281018671),
      surfaceContainerHighest: Color(4281742394),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4292198911),
      surfaceTint: Color(4291935485),
      onPrimary: Color(4280027201),
      primaryContainer: Color(4288317380),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4291938016),
      onSecondary: Color(4279833381),
      secondaryContainer: Color(4288056740),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294229194),
      onTertiary: Color(4281010967),
      tertiaryContainer: Color(4290151313),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      background: Color(4279505432),
      onBackground: Color(4293386472),
      surface: Color(4279505432),
      onSurface: Color(4294965759),
      surfaceVariant: Color(4282991950),
      onSurfaceVariant: Color(4291807443),
      outline: Color(4289110443),
      outlineVariant: Color(4287005067),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293386472),
      inverseOnSurface: Color(4281018671),
      inversePrimary: Color(4283383414),
      primaryFixed: Color(4293582335),
      onPrimaryFixed: Color(4279698236),
      primaryFixedDim: Color(4291935485),
      onPrimaryFixedVariant: Color(4282199139),
      secondaryFixed: Color(4293517048),
      onSecondaryFixed: Color(4279504416),
      secondaryFixedDim: Color(4291609307),
      onSecondaryFixedVariant: Color(4281938759),
      tertiaryFixed: Color(4294957538),
      onTertiaryFixed: Color(4280550929),
      tertiaryFixedDim: Color(4293966022),
      onTertiaryFixedVariant: Color(4283509558),
      surfaceDim: Color(4279505432),
      surfaceBright: Color(4282071102),
      surfaceContainerLowest: Color(4279176467),
      surfaceContainerLow: Color(4280097568),
      surfaceContainer: Color(4280360740),
      surfaceContainerHigh: Color(4281018671),
      surfaceContainerHighest: Color(4281742394),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294965759),
      surfaceTint: Color(4291935485),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4292198911),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294965759),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4291938016),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294965753),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4294229194),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      background: Color(4279505432),
      onBackground: Color(4293386472),
      surface: Color(4279505432),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4282991950),
      onSurfaceVariant: Color(4294965759),
      outline: Color(4291807443),
      outlineVariant: Color(4291807443),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293386472),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4281409366),
      primaryFixed: Color(4293845759),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4292198911),
      onPrimaryFixedVariant: Color(4280027201),
      secondaryFixed: Color(4293780220),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4291938016),
      onSecondaryFixedVariant: Color(4279833381),
      tertiaryFixed: Color(4294959078),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4294229194),
      onTertiaryFixedVariant: Color(4281010967),
      surfaceDim: Color(4279505432),
      surfaceBright: Color(4282071102),
      surfaceContainerLowest: Color(4279176467),
      surfaceContainerLow: Color(4280097568),
      surfaceContainer: Color(4280360740),
      surfaceContainerHigh: Color(4281018671),
      surfaceContainerHighest: Color(4281742394),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );

  /// Custom Color
  static const customColor = ExtendedColor(
    seed: Color(4282351303),
    value: Color(4282351303),
    light: ColorFamily(
      color: Color(4282015887),
      onColor: Color(4294967295),
      colorContainer: Color(4292076543),
      onColorContainer: Color(4278197305),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4282015887),
      onColor: Color(4294967295),
      colorContainer: Color(4292076543),
      onColorContainer: Color(4278197305),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4282015887),
      onColor: Color(4294967295),
      colorContainer: Color(4292076543),
      onColorContainer: Color(4278197305),
    ),
    dark: ColorFamily(
      color: Color(4288989694),
      onColor: Color(4278202717),
      colorContainer: Color(4280305782),
      onColorContainer: Color(4292076543),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4288989694),
      onColor: Color(4278202717),
      colorContainer: Color(4280305782),
      onColorContainer: Color(4292076543),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4288989694),
      onColor: Color(4278202717),
      colorContainer: Color(4280305782),
      onColorContainer: Color(4292076543),
    ),
  );


  List<ExtendedColor> get extendedColors => [
    customColor,
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
