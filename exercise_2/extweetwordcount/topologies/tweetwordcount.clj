(ns tweetwordcount
  (:use     [streamparse.specs])
  (:gen-class))

(defn tweetwordcount [options]
   [
    ;; spout configuration
    {"tweet-spout" (python-spout-spec
          options
          "spouts.tweets.Tweets"
          ["tweet"]
          :p 3
          :conf {
            "consumer_key": "5bul50atzZLo9NPdk2hRYjxVo"
            "consumer_secret": "Q7xYWQiviIkDvrDozh8FoRQpjySH0WBiO95plyPUyVk3eVJ9qq"
            "access_token": "179740020-OhRM9SzxGS8T2MfuvCb6Vxdo4edXFJF5fuAozpox"
            "access_token_secret": "U6L2y4OaOhSm4dx8MiQ7kOZTmJtuez9BBGeloWM9lXDQ0"
          }
          )
    }
    ;; bolt configuration
    {"parse-tweet-bolt" (python-bolt-spec
          options
          {"tweet-spout" :shuffle}
          "bolts.parse.ParseTweet"
          ["word"]
          :p 3
          )
     "count-bolt" (python-bolt-spec
          options
          {"parse-tweet-bolt" ["word"]}
          "bolts.wordcount.WordCounter"
          ["word" "count"]
          :p 2
          :conf {
            "username": "postgres"
            "password": "pass"
          }
          )
    }
  ]
)
