## ZOOKEEPER ALPINE LINUX

Данный докер собрал на Alpine Linux версия ZOOKEEPER v. 3.8.2 на java 11
помогает избавиться от всех лишних зависимостей и облегчить образ

Для сборки необходимо сделать пару команд
``` shel
git clone https://github.com/MikhailShapovalov26/zookeeper.alpine.git
cd zookeeper.alpine
docker build -t zookeeper .
docker run -d --name zoo -p 2181:2181 zookeeper
```
Вы можете использовать свои имена, названия контейнеров.</br>
Так же данный образ подходит для использования его в кластере Zookeeper docker compose, в Kubernetes.
Что-бы подготовить его, необходимо заполнить docker-compose.yaml для Ваших задач. Образец в директории

``` shell
docker-compose up -d 
```

Далее можно проверить, внимательно все настройки тестовые. 
```shell
docker ps -s
CONTAINER ID   IMAGE            COMMAND                  CREATED          STATUS          PORTS                                                                     NAMES     SIZE
7b2f1e921b3c   zookeeper_zoo3   "/docker-entrypoint.…"   16 minutes ago   Up 16 minutes   2888/tcp, 3888/tcp, 8080/tcp, 0.0.0.0:2183->2181/tcp, :::2183->2181/tcp   zoo3      32.9kB (virtual 343MB)
322089bb2b8a   zookeeper_zoo1   "/docker-entrypoint.…"   16 minutes ago   Up 16 minutes   2888/tcp, 3888/tcp, 0.0.0.0:2181->2181/tcp, :::2181->2181/tcp, 8080/tcp   zoo1      32.9kB (virtual 343MB)
874d39fa2276   zookeeper_zoo2   "/docker-entrypoint.…"   16 minutes ago   Up 16 minutes   2888/tcp, 3888/tcp, 8080/tcp, 0.0.0.0:2182->2181/tcp, :::2182->2181/tcp   zoo2      32.9kB (virtual 343MB)
```

Так же можно загрузить образ с docker hub для скачивания

```shell
docker pull mshapovalov/zookeeper.alpine.3.8.2:latest
```
Далее передать все необходимые параметры. 
