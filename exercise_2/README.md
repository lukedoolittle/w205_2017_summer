### Exercise 2 Setup

* Create an EC2 instance from the given UCB AMI ([launch in east-1](https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#LaunchInstanceWizard:ami=ami-d4dd4ec3))
* Clone this repository

      git clone https://github.com/lukedoolittle/w205_2017_summer.git

* Run the setup script from the exercise_2 directory

      cd w205_2017_summer/exercise_2
      ./setup.sh

* Insert the required credentials into `extweetwordcount/src/spouts/tweets.py`

* Create all postgres tables required

      python postgres_setup.py

* Start Storm

      cd extweetwordcount
      sparse run