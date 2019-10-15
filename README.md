# pingfederate v9.3.1 demo docker image

    docker pull ilanyu/pingfederate
    systemctl stop firewalld
    docker run -d --restart=always --network host ilanyu/pingfederate

open https://host:9999/pingfederate/app  
open https://host:9031/OAuthPlayground
