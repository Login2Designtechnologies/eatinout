# Eatinout

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
android {
namespace 'com.app.eatinout'}

    requirements for uploading app to play console
    - app name
    - app logo 512*512 up to 1 mb png or jpeg
    - app featured image 1024*512 up to 15 mb png or jpeg
    - phone screenshots at least 4 png or jpeg up to 8mb each 16:9 or 9:16 aspect ratio with each side between 320px and   3480px
    - app short description less then 80 char
    - app long description less then 4000 char
    - privacy policy url
    - account deletion url

buildscript {
    ext.kotlin_version = '1.9.0'
    repositories {
        google()
        mavenCentral()
        
    }

    dependencies {
        classpath 'com.google.gms:google-services:4.3.15'
       classpath 'com.android.tools.build:gradle:7.1.2'
        // classpath 'com.android.tools.build:gradle:8.1.1'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}

apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'
apply plugin: 'com.google.gms.google-services'
apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"
