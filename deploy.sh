export PORT=8000

DIR="/home/microblog/microblog"

echo 'Pulling latest version from git:'
git pull

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix release --env=prod

$DIR/bin/microblog stop || true

mix ecto.migrate

SRC=`pwd`
(cd $DIR && tar xzvf $SRC/_build/prod/rel/microblog/releases/0.0.1/microblog.tar.gz)

PORT=8000 $DIR/bin/microblog start
