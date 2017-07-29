### Exercise 2 Test Setup

* Create an EC2 instance from the given UCB AMI ([launch in east-1](https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#LaunchInstanceWizard:ami=ami-d4dd4ec3)). Make sure to attach an appropriate EBS (snap-06488e7dc1e6d9ca3)

* Get and run the setup script

      wget https://s3.amazonaws.com/lukedoolittle/setup.sh
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