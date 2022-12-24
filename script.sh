echo "1. Installing Docker"
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm -rf get-docker.sh
echo "2. Installing Docker compose"
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose
echo "3. Installing jenkins"
apt update
apt install openjdk-11-jre
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
apt-get update
apt-get install jenkins
systemctl enable jenkins
echo "4. Adding jenkins to docker group"
systemctl stop jenkins
usermod -a -G docker jenkins
systemctl start jenkins
echo "5. Jenkins password:"
cat /var/lib/jenkins/secrets/initialAdminPassword
