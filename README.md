# Terraform-EKS

Створив за допомогою Terraform одразу свою vpc на якій розмістив кластер, одразу надав кластеру доступ до ECR та доступ до кластеру юзеру AdminRole. Все у private subnets із private access endpoint, але з доступом до кластера через машини у тій ж vpc. Також додав CloudWatch addons для моніторингу.

# Результат на віртуалці
![Virtual machine](images/1.png)

# Результат на AWS - Cluster
![Cluster](images/2.png)

# Результат на AWS - Cluster Node
![Virtual machine](images/3.png)
