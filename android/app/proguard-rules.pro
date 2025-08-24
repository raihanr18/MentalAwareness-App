# Log filtering rules to reduce console spam
-assumenosideeffects class android.util.Log {
    public static *** v(...);
    public static *** d(...);
    public static *** i(...);
    public static *** w(...);
}

# Video/Media related optimizations
-keep class android.media.** { *; }
-keep class com.google.android.exoplayer2.** { *; }

# Buffer and surface optimizations
-dontwarn android.media.**
-dontwarn android.hardware.**

# Reduce ImageReader warnings
-assumenosideeffects class * {
    *** *ImageReader*(...);
}

# Flutter optimizations
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase optimizations
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**
