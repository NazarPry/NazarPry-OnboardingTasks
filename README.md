# Packer-Ansible-AMI

Встановив на віртуальну машину Ansible, Packer, AWS Cli для авторизації і роль os_hardening із колекції dev-sec. Написав packer file та playbook. Packer build створив інстанс, налаштував за роллю і створив AMI. Також все працювало без явного вказування ssh ключа, але захотів попробувати вказати певний ключ для підлючення і також працює.

# Результат на віртуалці
![Virtual machine](images/1.png)

# Результат у AWS консолі
![AWS](images/2.png)
