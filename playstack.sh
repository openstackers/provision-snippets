echo "Snippet - Playstack"
branch=$1

gem install configatron --no-ri --no-rdoc

git clone https://github.com/gildub/playstack.git /usr/local/playstack
cd /usr/local/playstack
git checkout $branch

/usr/local/playstack/setup.sh
