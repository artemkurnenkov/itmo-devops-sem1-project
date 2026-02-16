# Финальный проект 1 семестра

REST API сервис для загрузки и выгрузки данных о ценах.

## Требования к системе

1. Debian 12 (bookworm).
2. PostgreSQL 16 или выше.
3. Go 1.23.5 или выше.

## Установка и запуск

1. Установка пакетов для PostgreSQL и Go:

```bash
sudo apt update -y && \
    sudo apt install -y postgresql \
    git \
    curl \
    wget \
    tar && \
    sudo rm -rf /usr/local/go && \
    wget https://golang.org/dl/go1.23.5.linux-amd64.tar.gz && \
    sudo mkdir -p /usr/local && \
    sudo tar -C /usr/local -xzf go1.23.5.linux-amd64.tar.gz && \
    rm -rf go1.23.5.linux-amd64.tar.gz && \
    sudo apt clean && \
    sudo rm -rf /var/lib/apt/lists/*
```

2. Экспорт переменной PATH для работы Go:

```bash
export PATH=$PATH:/usr/local/go/bin
```

3. Загрузка Git репозитория и переход в рабочую директорию:

```bash
git clone https://github.com/artemkurnenkov/itmo-devops-sem1-project.git && cd itmo-devops-sem1-project
```

4. Добавить права на запуск скриптов:

```bash
chmod +x scripts/*.sh
```

5. Запуск скрипта для установки зависимостей приложения:

```bash
./scripts/prepare.sh
```

5. Запуск сервера:

```bash
./scripts/run.sh
```

## Тестирование

Директория `sample_data` - это пример директории, которая является разархивированной версией файла `sample_data.zip`

1. Запуск тестов:

```bash
./scripts/tests.sh
```

Пример POST-запроса `POST /api/v0/prices` c параметром в виде CSV-файла в формате ZIP-архива для записи в базу данных:

```bash
curl -X POST -F "file=@sample_data.zip" http://localhost:8080/api/v0/prices
```

Пример GET-запроса `GET /api/v0/prices` для выгрузки записей из базы данных:

```bash
curl -X GET -o response.zip http://localhost:8080/api/v0/prices
```

## Контакт

Artem Kurnenkov\
email: artemkurnenkov@gmail.com
