alias nerd="lima nerdctl"

function start-local-apache() {
    limactl start default
    lima nerdctl rm apache
    lima nerdctl run -d \
      --name apache \
      -p 127.0.0.1:80:80 \
      -p 127.0.0.1:443:443 \
      --mount type=bind,source=/Users/tri11276/wwwtest,target=/usr/local/apache2/htdocs/wwwtest,rw \
      apache_local
}