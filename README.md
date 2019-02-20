# Рабочее окружение для анализа данных

# Подготовка машины к работе

## Описание рабочей среды

Занятия будут проходить в ОС Ubuntu 18.04 LTS. Установка необходимых баз данных (Mongo, Postgres, Redis, etc.) с помощью утилиты виртуализации Docker.

Перед работой с командной строкой обновим список пакетов - нужно выполнить в консоли команду:

<pre>
sudo apt-get update && sudo apt-get -y upgrade
</pre>

Эта команда обновит пакетный менеджер apt-get. После этого установить менеджер пакетов pip и вспомогательные утилиты (unzip, git).
Пакет pip - это менеджер пакетов python, его помощью можно будет устанавливать python библиотеки. Утилита unzip - программа для распаковки архивов.:

<pre>
sudo apt-get install python-pip unzip git
</pre>

Теперь скачиваем репозиторий курса

<pre>
git clone https://github.com/Dju999/data_analysis.git
</pre>

## Установка docker

Для проверки установки выполним команду
<pre>
docker run hello-world
</pre>

Если не получилось - установим docker, согласно [Инструкции тут](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

Кроме докера поставим docker-compose

<pre>
sudo apt-get install docker-compose
</pre>

Подготовка завершена! Один раз проделав этот пункт, можно к нему больше не возвращаться

### Работа c репозиторием в Docker

Переходим в корневую директорию репозитория
<pre>
cd data_analysis
</pre>

Запускаем сборку контейнера, консоли побежит информация об установке системных пакетов.
<pre>
docker build -t ds_docker:latest .
</pre>

Запускаем сборку окружения pipenv
<pre>
docker run --volume $(pwd)/app:/www/app -it --rm ds_docker:latest pipenv
</pre>

В результате в репозитории появится окружение .venv, в котором будут запускаться ноутбуки. Выхлоп команды:
<pre>
Installing dependencies from Pipfile.lock (5fe059)…
  🐍   ▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉ 54/54 — 00:00:25
To activate this project's virtualenv, run pipenv shell.
Alternatively, run a command inside the virtualenv with pipenv run.
</pre>

Запускаем сеанс `jupyter notebook`:
<pre>
docker run --volume $(pwd)/app:/www/app -it --rm ds_docker:latest jupyter
</pre>

Выхлоп консоли
<pre>
[I 04:34:40.569 NotebookApp] Writing notebook server cookie secret to /root/.local/share/jupyter/runtime/notebook_cookie_secret
[I 04:34:40.766 NotebookApp] Serving notebooks from local directory: /www/app
[I 04:34:40.766 NotebookApp] The Jupyter Notebook is running at:
[I 04:34:40.766 NotebookApp] http://(970e0486f4cb or 127.0.0.1):8888/?token=490f1634bc9aac268b637e69ff284c28fddab00404914b40
</pre>

Для проверки открываем в браузере страницу, на которой будт форма для ввода токена
<pre>
http://127.0.0.1:8889
</pre>

После ввода токена будет запущен сеанс Jupyter Notebook.

## Решение проблем с docker

Если контейнер не стартует с ошибкой
<pre>
docker: Error response from daemon: Conflict. The container name "/netology-postgres" is already in use by container "2a99cb6629b78e7b5b6747a9bd453263940127909d91c8517e9ee0b230e60768". You have to remove (or rename) that container to be able to reuse that name.
</pre>

То контейнер уже создан и можно стартовать его
<pre>
sudo docker start 2a99cb6629b78e7b5b6747a9bd453263940127909d91c8517e9ee0b230e60768
</pre>

Если не помогло - надо бы остановить все запущенные докер-образы и удалить их

<pre>
docker stop $(sudo docker ps -a -q)
docker rm $(sudo docker ps -a -q)
</pre>

Удаление всех образов
<pre>
docker rmi $(docker images -q)
</pre>

Параметры docker run, остальные параметры [тут](https://docs.docker.com/v1.11/engine/reference/commandline/run/)

<code>
--name - Assign a name to the container

-d, --detach - Run container in background and print container ID

-e - устанавливаем переменную среды

-it - запустить интеракцивный терминал
</pre>
