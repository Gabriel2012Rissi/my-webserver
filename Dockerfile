FROM ubuntu:16.04

MAINTAINER Gabriel Rissi <gabriel2012rissi@gmail.com>

# Definir variável de diretório padrão
ENV MY_DIR /home/webmaster

# Atualizar cache
RUN apt-get update && \
    apt-get upgrade -y

# Instalar requisitos para o pip
RUN apt-get -y install python-pip

# Instalar o Ansible via pip
RUN pip install ansible

# Copiar os arquivos para o container
COPY ansible_tasks /opt/ansible_tasks

# Criar novo usuário webmaster
RUN useradd -ms /bin/bash webmaster
RUN usermod -aG www-data webmaster

USER webmaster

# Criar um link simbólico
RUN ln -s /var/www/html ${MY_DIR}/projects
WORKDIR ${MY_DIR}/projects

USER root

# Executar o playbook
RUN ansible-playbook -i /opt/ansible_tasks/hosts/my_hosts \
    /opt/ansible_tasks/playbook.yml

# Efetuar uma limpeza dos pacotes
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Rodar o apache2 em primeiro plano
ENTRYPOINT ["apache2ctl", "-D", "FOREGROUND"]

# Expor a porta 80
EXPOSE 80
