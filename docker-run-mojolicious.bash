docker build --no-cache --rm -f Containerfile -t mojolicious:demo .
docker run --interactive --tty -p 8080:8080 mojolicious:demo
echo "browse http://localhost:8080/"
