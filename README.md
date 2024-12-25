# 使用方法

    # 容器中
    $ docker cp x-pack-core-*.crack.jar docker-elk_elasticsearch_1:/usr/share/elasticsearch/modules/x-pack-core/
    $ docker exec -it --user root docker-elk_elasticsearch_1 /bin/bash
    $ cd /usr/share/elasticsearch/modules/x-pack-core/ && mv x-pack-core-8.0.0.jar x-pack-core-8.0.0.jar.bak
    $ mv x-pack-core-8.0.0.crack.jar x-pack-core-8.0.0.jar
    $ docker restart docker-elk_elasticsearch_1

    # 删除容器数据
    $ docker volume ls -q |grep elastic |xargs docker volume rm
    
    # linux系统中
    $ cp -f x-pack-core-8.0.0.jar  /usr/share/elasticsearch/modules/x-pack-core/
    # 覆盖原文件，如果是集群，需要所有节点都需要此操作。
    $ systemctl restart elasticsearch.service 
    # 重启生效
