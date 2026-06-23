# Video Downloader

Кроссплатформенный загрузчик видео и аудио с графическим интерфейсом на Python + Tkinter.

## Возможности

- Скачивание видео и аудио с YouTube и сотен других сайтов (через yt-dlp)
- Выбор качества (360p – 1080p+) и контейнера (MP4, MKV, WebM)
- Скачивание отдельных видео или целых плейлистов
- Превью: миниатюра, название, длительность, автор
- Пакетная очередь загрузок параллельность 1–5 файлов одновременно
- Проверка свободного места на диске перед скачиванием
- Локализация: русский и английский языки
  - Автовыбор по языку ОС
  - Смена языка в настройках (событие применяется при следующем запуске)
- Темная/светлая тема
- Системный трей (сворачивание в трей во время загрузки)
- Проверка и обновление yt-dlp
- Установщик Windows (Inno Setup) с выбором языка и опциональной установкой VLC

## Скриншоты

_Скриншоты будут добавлены позже_

## Быстрый старт

### Требования

- Python 3.9+
- pip

### Установка зависимостей

```bash
pip install yt-dlp pillow pystray tkinterdnd2
```

> `pillow`, `pystray`, `tkinterdnd2` — опциональны. Без них приложение работает, но без превью, системного трея и drag & drop соответственно.

### Запуск из исходников

```bash
python downloader.py
```

## Сборка .exe (Windows)

### 1. Собрать исполняемый файл

```bash
build (5).bat
```

Результат: `downloader.exe`

### 2. Собрать установщик

```bash
build_installer_only.bat
```

Результат: `installer\VideoDownloader-Setup.exe`

## Структура проекта

```
.
├── downloader.py                 # Точка входа
├── build (5).bat                 # Сборка .exe (Nuitka)
├── build_installer_only.bat      # Сборка установщика (Inno Setup)
├── downloader-installer.iss      # Скрипт Inno Setup
├── icon.ico                      # Иконка приложения
├── ffmpeg.exe                    # FFmpeg (склеивание видео+аудио)
├── ffprobe.exe                   # FFprobe (проверка потоков)
├── vlc-3.0.23-win64.exe          # VLC (опционально, для HEVC)
├── installer/
│   └── VideoDownloader-Setup.exe # Готовый установщик
└── app/
    ├── __init__.py
    ├── config.py                 # Настройки (JSON, %APPDATA%)
    ├── gui/
    │   ├── __init__.py           # Re-exports App, main
    │   ├── app.py                # Основной класс App и точка входа main()
    │   ├── builders.py           # Построение виджетов интерфейса
    │   ├── handlers.py           # Обработчики событий
    │   ├── preview.py            # Превью видео
    │   ├── settings.py           # Окно настроек
    │   ├── queue.py              # Управление очередью
    │   └── download.py           # Запуск загрузок
    ├── core/
    │   ├── __init__.py           # Публичный API ядра
    │   ├── formats.py            # Построение format-строк для yt-dlp
    │   ├── download.py           # Логика скачивания
    │   └── metadata.py           # Валидация URL, проверка хоста, место на диске
    ├── i18n.py                   # Локализация (ru / en)
    ├── queue_model.py            # Модель элемента очереди
    ├── theme.py                  # Цветовые схемы (светлая/тёмная)
    ├── tray.py                   # Системный трей
    └── updater.py                # Проверка обновления yt-dlp
```

## Настройки

Приложение хранит настройки в `%APPDATA%\VideoDownloader\config.json`:

```json
{
  "last_save_path": "C:\\Users\\...\\Videos",
  "container_format": "mp4",
  "dark_theme": false,
  "max_parallel": 2,
  "language": "ru",
  "saved_queue": []
}
```

## Сборка из исходников

### Зависимости для сборки

- Nuitka
- Inno Setup 6
- FFmpeg / FFprobe
- yt-dlp (ставится автоматически перед сборкой)

### Процесс

1. `build (5).bat` компилирует `downloader.py` в `downloader.exe` через Nuitka
2. `build_installer_only.bat` запускает Inno Setup и упаковывает `downloader.exe` + `ffmpeg.exe` + `ffprobe.exe` + `vlc` в `VideoDownloader-Setup.exe`
