#!/bin/bash

DIR=$(realpath $(dirname $0))

echo "Checking noxcoind..."
noxcoind=""
for dir in \
  . \
  "$DIR" \
  "$DIR/../.." \
  "$DIR/build/release/bin" \
  "$DIR/../../build/release/bin" \
  "$DIR/build/Linux/master/release/bin" \
  "$DIR/../../build/Linux/master/release/bin" \
  "$DIR/build/Windows/master/release/bin" \
  "$DIR/../../build/Windows/master/release/bin"
do
  if test -x "$dir/noxcoind"
  then
    noxcoind="$dir/noxcoind"
    break
  fi
done
if test -z "$noxcoind"
then
  echo "noxcoind not found"
  exit 1
fi
echo "Found: $noxcoind"

TORDIR="$DIR/noxcoin-over-tor"
TORRC="$TORDIR/torrc"
HOSTNAMEFILE="$TORDIR/hostname"
echo "Creating configuration..."
mkdir -p "$TORDIR"
chmod 700 "$TORDIR"
rm -f "$TORRC"
cat << EOF > "$TORRC"
ControlSocket $TORDIR/control
ControlSocketsGroupWritable 1
CookieAuthentication 1
CookieAuthFile $TORDIR/control.authcookie
CookieAuthFileGroupReadable 1
HiddenServiceDir $TORDIR
HiddenServicePort 18083 127.0.0.1:18083
EOF

echo "Starting Tor..."
nohup tor -f "$TORRC" 2> "$TORDIR/tor.stderr" 1> "$TORDIR/tor.stdout" &
ready=0
for i in `seq 10`
do
  sleep 1
  if test -f "$HOSTNAMEFILE"
  then
    ready=1
    break
  fi
done
if test "$ready" = 0
then
  echo "Error starting Tor"
  cat "$TORDIR/tor.stdout"
  exit 1
fi

echo "Starting noxcoind..."
HOSTNAME=$(cat "$HOSTNAMEFILE")
"$noxcoind" \
  --anonymous-inbound "$HOSTNAME":18083,127.0.0.1:18083,25 --tx-proxy tor,127.0.0.1:9050,10 \
  --add-priority-node zbjkbsxc5munw3qusl7j2hpcmikhqocdf4pqhnhtpzw5nt5jrmofptid.onion:18083 \
  --add-priority-node 2noxnode5itf65lz.onion:18083 \
  --detach
ready=0
for i in `seq 10`
do
  sleep 1
  status=$("$noxcoind" status)
  echo "$status" | grep -q "Height:"
  if test $? = 0
  then
    ready=1
    break
  fi
done
if test "$ready" = 0
then
  echo "Error starting noxcoind"
  tail -n 400 "$HOME/.bitnoxcoin/bitnoxcoin.log" | grep -Ev stacktrace\|"Error: Couldn't connect to daemon:"\|"src/daemon/main.cpp:.*noxcoin\ \'" | tail -n 20
  exit 1
fi

echo "Ready. Your Tor hidden service is $HOSTNAME"
