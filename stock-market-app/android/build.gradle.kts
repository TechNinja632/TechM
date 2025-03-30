plugins {
  id("com.android.application")
  // ...

  // Add the dependency for the Google services Gradle plugin
  id("com.google.gms.google-services") version "4.4.2" apply false
}

android {
    namespace = "com.example.stocks_app"
    compileSdk = 34
    ndkVersion = "27.0.12077973"

sourceSets {
        getByName("main") {
            manifest.srcFile("app/src/main/AndroidManifest.xml")
            java.srcDirs("app/src/main/java")
            res.srcDirs("app/src/main/res")
        }
    }

}
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}
