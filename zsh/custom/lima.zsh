alias nerd="lima nerdctl"

function start-local-apache() {
    echo 🔵 Starting local Apache server
    HOME_ABSOLUTE = $(realpath "${HOME}")
    limactl start default
    lima nerdctl rm apache
    lima nerdctl run -d \
      --name apache \
      -p 127.0.0.1:80:80 \
      -p 127.0.0.1:443:443 \
      --mount type=bind,source="${HOME_ABSOLUTE}/site/esri",target=/usr/local/apache2/htdocs/site/esri,rw \
      apache_local
}