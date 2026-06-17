# organize_downloads.ps1

PowerShell-скрипт для автоматической сортировки файлов в папке **Downloads** по расширениям.

## Что делает скрипт

Скрипт просматривает файлы в папке загрузок пользователя:

```powershell
$env:USERPROFILE\Downloads
```

и раскладывает их по подпапкам с названиями расширений файлов.

Например:

```text
Downloads
├── PDF
│   └── document.pdf
├── JPG
│   └── photo.jpg
├── ZIP
│   └── archive.zip
└── NO_EXTENSION
    └── README
```

Файлы без расширения помещаются в папку `NO_EXTENSION`.

## Особенности

* Сортирует только файлы из корня папки `Downloads`.
* Не обрабатывает вложенные папки.
* Не перемещает сам файл скрипта, если он находится в `Downloads`.
* Автоматически создаёт папки для расширений.
* Если файл с таким именем уже существует в целевой папке, к имени добавляется timestamp.
* После завершения показывает количество перемещённых файлов.

## Требования

* Windows
* PowerShell 5.0 или новее

## Запуск

Откройте PowerShell и выполните:

```powershell
.\organize_downloads.ps1
```

Если выполнение скриптов запрещено политикой безопасности, можно запустить так:

```powershell
powershell -ExecutionPolicy Bypass -File .\organize_downloads.ps1
```

## Пример результата

```text
Folder: C:\Users\User\Downloads
Sorting files by extension...
  Created folder: PDF
  OK: invoice.pdf -> PDF\
  Created folder: JPG
  OK: image.jpg -> JPG\

Done! Files moved: 2
Press any key to exit...
```

## Важно

Скрипт перемещает файлы физически. Перед первым запуском рекомендуется проверить содержимое папки `Downloads` или протестировать скрипт на небольшой папке с копиями файлов.
