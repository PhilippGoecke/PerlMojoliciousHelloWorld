podman build --no-cache --rm -f Containerfile -t mojolicious:demo .
podman run --interactive --tty -p 8080:8080 mojolicious:demo
echo "browse http://localhost:8080/?name=test"
