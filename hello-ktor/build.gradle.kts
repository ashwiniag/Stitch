import com.github.jengelman.gradle.plugins.shadow.tasks.ShadowJar
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
  kotlin("jvm") version "1.3.50"
  id("com.github.johnrengelman.shadow") version "5.1.0"
}

group = "org.njk.tech"
version = "1.0"

repositories {
  mavenCentral()
  jcenter()
}

dependencies {
  implementation(kotlin("stdlib-jdk8"))
  compile("io.ktor", "ktor-server-netty", "1.2.4")
  testCompile("junit", "junit", "4.12")
}

configure<JavaPluginConvention> {
  sourceCompatibility = JavaVersion.VERSION_1_8
}

tasks {
  named<ShadowJar>("shadowJar") {
    archiveBaseName.set("hello-ktor")
    mergeServiceFiles()
    manifest {
      attributes(mapOf("Main-Class" to "org.njk.tech.helloktor.MainKt"))
    }
  }
}

tasks.withType<KotlinCompile> {
  kotlinOptions.jvmTarget = "1.8"
}