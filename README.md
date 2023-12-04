# Grafana-Kubernetes

Це простий скрипт, що піднімає Grafana, Prometheus, Node-exporter на K8S за допомогою VirtualBox, Minikube та kubectl. Працює за наявності virtualbox, minikube та kubectl у системі Проект протестовано на системі Debian (Parrot OS 5.4), але повинен працювати на інших Unix-подібних системах.

## Використання

1. Завантажте цей репозиторій:

    ```bash
    git clone https://github.com/jj975/Grafana-Kubernetes.git
    cd Grafana-Kubernetes
    ```

2. Просто запустіть скрипт start.sh:

    ```bash
    bash ./start.sh
    ```

3. Перегляньте вивід виконання команд для доступу до сервісів:

    - Для перегляду інформації про ноди використовуйте:

        ```bash
        kubectl get nodes -o wide
        ```
        **Приклад результату команди:**
        ```plaintext
        NAME      STATUS   ROLES           AGE   VERSION   INTERNAL-IP      EXTERNAL-IP   OS-IMAGE               KERNEL-VERSION   CONTAINER-RUNTIME
        grafana   Ready    control-plane   7s    v1.28.3   192.168.59.127   <none>        Buildroot 2021.02.12   5.10.57          docker://24.0.7
        ```
        Де `192.168.59.127` це глобальна IP кластера, надана адаптером VirtualBox host-only. У браузері до сервісів потрібно звертатися саме до цієї IP адреси.

    - Для перегляду інформації про сервіси використовуйте:

        ```bash
        kubectl get service
        ```
        **Приклад результату команди:**
        ```plaintext
        NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
        grafana-service         NodePort    10.108.69.224   <none>        3000:32317/TCP   1s
        kubernetes              ClusterIP   10.96.0.1       <none>        443/TCP          5s
        node-exporter-service   NodePort    10.110.92.72    <none>        9100:30737/TCP   0s
        prometheus-service      NodePort    10.102.35.200   <none>        9090:32466/TCP   0s
        ```
        Де `3000:32317` це прокидка порту 3000, що відповідає сервісу Grafana, на 32317, за яким необхідно з'єднуватись до сервісу Grafana у браузері серверу, де запускається скрипт. Порт 32317 та інші назначаються випадковим чином Kubernetes.
        Відповідно:
        - `9100:30737` - прокидка сервісу Node-Exporter.
        - `9090:32466` - прокидка сервісу Prometheus.

Отже, для доступу до сервісів, що описані у маніфестах, потрібно у браузерному рядку використовувати такі посилання:

- `192.168.59.127:32317` - для доступу до Grafana.
- `192.168.59.127:32466` - для доступу до Prometheus.
- `192.168.59.127:30737` - для доступу до Node-Exporter.

**Зауваження:**
Будьте уважні, що надані порти можуть бути випадково присвоєні Kubernetes і змінюватися з кожним запуском. Рекомендується перевіряти результати цих команд кожного разу для отримання актуальних даних про доступ до сервісів.

### Докладно про сервіси: Grafana

Grafana - веб-застосунок моніторингової системи, що має інструменти показу даних про стан хостів з Prometheus серверу, такі як графіки, сповіщення, дашборди тощо. Якщо ви вперше бачете таку систему, то варто мати базові навички як під'єднати до нього Prometheus сервер згідно таких кроків:

1. У лівому верхньому куту натисніть на кнопки за такою послідовністю: Toggle menu > Connections > Add new connection
2. Знайдіть пункт Prometheus та натисніть, далі Add new data source
3. У розділі Connection у полі Prometheus server URL уведіть `http://prometheus-service:9090` та збережіть, натиснувши внизу сторінки Save & test. Якщо все правильно, то результат має бути таким повідомленням:

    ```
    Successfully queried the Prometheus API.
    Next, you can start to visualize data by building a dashboard, or by querying data in the Explore view.
    ```

Після під'єднання серверу необхідно додати дашборд для візуальної оцінки роботи системи. Для цього потрібно:

1. У лівому верхньому куту натисніть на кнопки за такою послідовністю: Toggle menu > Dashboards.
2. Натисніть на праву кнопку New і у спадному списку виберіть import
3. У полі Find and import dashboards for common applications at grafana.com/dashboards уведіть 1860, це базовий ID для моніторингу Node-Exporter, та натисніть правіше кнопку Load.
4. Виберіть джерелом даних у спадному списку форми Prometheus щойно створений data source Prometheus і натисніть на нижню ліву кнопку Import.

_Примітка:_
Якщо ви вже створювали з цим ID дашборд, то виникнуть ряд помилок щодо унікальності Name та Unique identifier (UID). Для їх вирішення потрібно просто зробити унікальним і натиснути на Import.
