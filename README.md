# Grafana-Kubernetes

Це простий скріпт, що піднімає Grafana, Prometheus, Node-exporter на K8S за допомогою virtualbox, minikube та kubectl. 
Працює за наявності virtualbox, minikube та kubectl у системі. 
Проект тестувався в системі Debian (Parrot os 5.4), однак він спрацює і на інших Unix-системах

# Використання: 
1. Завантажте цей репрозиторій

git clone https://github.com/jj975/Grafana-Kubernetes.git
cd Grafana-Kubernetes

2. Просто запускайте скрипт start.sh

bash ./start.sh

3. Погляньте вивід виконання команд kubectl get nodes -o wide та kubectl get service у скрипту.
   Звітси ви маєте дістати IP ноди та порти доступу до сервесів. Наприклад:


