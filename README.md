# Project 3 - *twitter-client*

**twitter-client** is a basic twitter app to read and compose tweets from the [Twitter API](https://apps.twitter.com/).

Time spent: **10** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User can sign in using OAuth login flow.
- [X] User can view last 20 tweets from their home timeline.
- [X] The current signed in user will be persisted across restarts.
- [X] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.  In other words, design the custom cell with the proper Auto Layout settings.  You will also need to augment the model classes.
- [X] User can pull to refresh.
- [X] User can compose a new tweet by tapping on a compose button.
- [X] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.

The following **optional** features are implemented:

- [X] When composing, you should have a countdown in the upper right for the tweet limit.
- [X] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [X] Retweeting and favoriting should increment the retweet and favorite count.
- [X] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [X] Replies should be prefixed with the username and the reply_id should be set when posting the tweet,
- [X] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.

The following **additional** features are implemented:

- [X] Delete your own tweets
- [X] Show verified status for verified users
- [X] Color indicators for liked and retweeted tweets

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Easier ways to set up auto-layout when you want to add a new element. When I wanted to add new features, my old auto-layout constraints needed to be completely reset. Also, centering items horizontally across a fixed width would be cool (e.g. evenly space 4 items across some width).
2. Retweets were confusing! How did you handle the retweet/unretweet actions? Especially when you retweet a retweet - the parent tweet becomes the originally retweeted status, which could be far removed from the status you retweeted from.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

OAuth login and general functionality:
<div>
    <img src='http://image.ibb.co/b88WJw/twitter_client_4.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
</div>
<br>

Infinite scroll and table layout:
<div>
    <img src='http://image.ibb.co/crO1kb/twitter_client_2.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
</div>
<br>

Posting, replying, and deleting:
<div>
    <img src='http://image.ibb.co/fkkp5b/twitter_client_7.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
</div>
GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Mainly the two questions cited above. Auto-layout is difficult when you want to add a new element. I had a few issues getting oauth to work because I started with the videos from the "resources" tab, which felt very out of date. The videos from the assignments tab were much more updated and helpful. Finally, handling retweets was confusing in some instances, like retweeting a retweet.

## Acknowledgements

All icons courtesy of [iconmonstr](https://iconmonstr.com/)

## License

    Copyright [2017] [Paul Sokolik]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
