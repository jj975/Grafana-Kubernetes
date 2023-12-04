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
