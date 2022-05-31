# inno_versioning plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-inno_versioning)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-inno_versioning`, add it to your project by running:

```bash
fastlane add_plugin inno_versioning
```

## About inno_versioning

Плагин для автоматизации версионирования. 

На билд-машине должен хранится json-файл с версиями, в котором хранятся все актуальные версии. В плагине описаны правила подъема номера версии для 3 версий приложения: beta, rc, release.
Есть три типа методов для каждой версии: 
1) get_version - получить объект версии для текущего лейна (например, inno_get_beta_version),
2) increment_version - увеличить номер версии (например, inno_increment_beta_version),
3) save_version - увеличить номер версии (например, inno_save_beta_version).

Правила инкремента номеров версий:

** Beta **
При инкременте бета версии проверяется, не выше ли она версии RC. Если бета версия выше версии релиз кандидата, то инкрементится номер билда. В противном случае номер бета версии становится равном версии релиз кандидата, но с минорным номер на 1 выше. Пример:
```  
// Если RC выше или равен бете (0.1.1(0)):
'0.1.0(4)' -> '0.2.0(0)'

// В противном случае
'0.1.0(1)' -> '0.1.0(2)'
```

** Release Candidate **

При инкременте версии Release Candidate6 проверяется, если release версия меньше, то увеличивается patch номер (случай когда перед релизом выпускаются хотфиксы для релиз кандидата). В противном случае инкрементится minor и сбрасывается patch. Пример:
```  
// Если release выше или равен rc:
'0.1.0(0)' -> '0.2.0(0)'

// В противном случае
'0.1.0(0)' -> '0.1.1(0)'
```

Для iOS проектов есть еще опция поднятия мажорной версии. Для этого надо в проекте поднять мажорную версию в настройках проекта, она автоматически подтянется:
```
'1.2.0(0)' -> '2.0.0(0)'
```

в случае использования для андроид проектов надо сделать МР в плагин или вручную поправить файл версий

## Example

Пример содержания файла с версиями:
```
{"beta":"0.5.0(1)","rc":"0.4.0(0)","release":"0.3.2(0)"}
```

Пример использования в лейне Fastfile:

```
versions_dir = '~/app_versions/comitet/versions.json'
v = inno_get_beta_version(path: versions_dir)
UI.message('Beta version = ' + v.toString)
v = inno_increment_beta_version(path: versions_dir)

increment_version_number(version_number: v.major.to_s + '.' + v.minor.to_s + '.' + '0')
increment_build_number(build_number: v.build)

build_ios_app(
  scheme: "Comitet Beta",
  export_method: "development"
)

appcenter_upload(
  api_token: ENV["APPCENTER_ACCESS_TOKEN"],
  owner_name: "Digital-Board",
  owner_type: "organization",
  app_name: "Komitet",
  notify_testers: false,
  release_notes: ENV["CI_COMMIT_TITLE"]
)
version_details = appcenter_fetch_version_number(
  api_token: ENV["APPCENTER_ACCESS_TOKEN"],
  owner_name: "Digital-Board",
  app_name: "Komitet"
)
inno_save_beta_version(path: versions_dir, version: v)
```