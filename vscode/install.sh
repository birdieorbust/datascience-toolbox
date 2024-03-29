set -o nounset -i errexit -o pipefail

#install code-server  
cd /opt && \
  mkdir /opt/code-server && \
  cd /opt/code-server && \
  wget -qO- https://github.com/cdr/code-server/releases/download/1.1156-vsc1.33.1/code-server1.1156-vsc1.33.1-linux-x64.tar.gz | tar zxvf - --strip-components=1

#install the python extension for vs-code
apt-get update -y
apt-get install -y bsdtar curl
mkdir -p /home/ubuntu/.local/share/code-server/extensions/ms-python.python-2019.6.24221 && \
cd /home/ubuntu/.local/share/code-server/extensions/ms-python.python-2019.6.24221
curl -JL https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-python/vsextensions/python/2019.6.24221/vspackage | bsdtar -xvf - extension

cd /home/ubuntu/.local/share/code-server/extensions/ms-python.python-2019.6.24221/extension/ && mv * ../

#chown -R ubuntu:ubuntu /home/ubuntu/.local/share/code-server/

export PATH="/opt/code-server:$PATH"
echo $PATH

rm -rf /var/lib/apt/lists/*