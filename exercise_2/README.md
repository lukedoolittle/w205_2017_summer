### Exercise 2 Setup

* Create an EC2 instance from the given UCB AMI ([launch in east-1](https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#LaunchInstanceWizard:ami=ami-d4dd4ec3))

* Get and run the setup script

      wget https://raw.githubusercontent.com/lukedoolittle/w205_2017_summer/master/exercise_2/setup.sh?token=AB0QhH9MmObh_uG4CseBTrdwsaGoAawwks5ZfbqqwA%3D%3D
      chmod +x setup.sh
      ./setup.sh

* Switch to W205 user and clone this repository

      su - w205
      git clone https://lukedoolittle@github.com/lukedoolittle/w205_2017_summer.git

* Create all postgres tables required

      cd w205_2017_summer/exercise_2
      python postgres_setup.py

* Start Storm

      cd extweetwordcount
      sparse run