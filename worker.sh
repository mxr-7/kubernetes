swapoff -a
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
apt-get install -y apt-transport-https curl
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
docker run hello-world
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install kubelet kubeadm kubectl -y 
apt-mark hold kubelet kubeadm kubectl
modprobe br_netfilter
echo 1 > /proc/sys/net/ipv4/ip_forward
mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
nano /etc/containerd/config.toml
